`define WORD_SIZE 32

//  Register File Module
module RegisterFile(
        address1, address2, address3, data_out1, data_out2, data_in, clock, write_enable, reset
    );
    
    // Declare Input Variables
    input clock, write_enable, reset;
    input [1:0] address1, address2, address3;
    input [`WORD_SIZE-1:0] data_in;
    
    // Declare Output Variables
    output [`WORD_SIZE-1:0] data_out1, data_out2;
    
    // Registers
    reg [`WORD_SIZE-1:0] registers[3:0];
    initial registers[0] = 32'h12345678;
    initial registers[1] = 32'h9ABCDEF0;
    initial registers[2] = 32'hFFFFFFFF;
    initial registers[3] = 32'h00000001;
    
    assign data_out1 = registers[address1];
    assign data_out2 = registers[address2];
   
    always @(posedge clock) begin
        if(reset) begin
            registers[0] <= 0;
            registers[1] <= 0;
            registers[2] <= 0;
            registers[3] <= 0;
        end
        if(write_enable) begin
            registers[address3] <= data_in;
        end
    end
endmodule

//iverilog -o regfile regfile.v

`include "soru1"

module alu_tb;

reg [31:0] a, b;
reg [2:0] alucontrol;
wire [31:0] result;
wire cout;

// Instantiate the ALU
alu_32bit alu (
    .result(result),
    .cout(cout),
    .a(a), 
    .b(b),
    .alucontrol(alucontrol)
);

initial begin
    a = 32'habcdef12; b = 32'h00000043; alucontrol = 3'b000;#10; // add
    a = 32'h12345678; b = 32'h00000078; alucontrol = 3'b001;#10; // sub
    a = 32'habcdef00; b = 32'hf0f0f0f0; alucontrol = 3'b010;#10; // and
    a = 32'hffffffff; b = 32'h0f0f0f0f; alucontrol = 3'b011;#10; // xor
    a = 32'haaaaaaaa; b = 32'hbbbbbbbb; alucontrol = 3'b101;#10; // slt
end

initial begin
    $monitor("Time = %t, alucontrol = %b, a = %h, b = %h, result = %h", $time, alucontrol, a, b, result);
end

initial begin
        $dumpfile("Soru1.vcd");
        $dumpvars(0, alu_tb);
        
    end

endmodule



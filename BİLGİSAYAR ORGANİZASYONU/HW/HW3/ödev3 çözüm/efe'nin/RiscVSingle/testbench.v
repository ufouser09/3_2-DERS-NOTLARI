module testbench();
    reg clk;
    reg reset;
    wire [31:0] WriteData, DataAdr;
    wire MemWrite;
    integer i;

    top uut (
        .clk(clk), 
        .reset(reset), 
        .WriteData(WriteData), 
        .DataAdr(DataAdr), 
        .MemWrite(MemWrite)
    );

    initial begin
        reset <= 1;
        #22; 
        reset <= 0;
    end

    always begin
        clk <= 1; 
        #5; 
        clk <= 0; 
        #5;
    end

    // Check results and display progress
    always @(negedge clk) begin
        $display("At time %t: DataAdr = %0d, WriteData = %0d, MemWrite = %0b", $time, DataAdr, WriteData, MemWrite);
        if (MemWrite) begin
            $display("Memory Write: Address = %0d, Data = %0d", DataAdr, WriteData);
            if (DataAdr === 100 && WriteData === 25) begin
                $display("Simulation succeeded");
                $stop;
            end else if (DataAdr !== 96) begin
                $display("Simulation failed at Address = %0d, Data = %0d", DataAdr, WriteData);
                $stop;
            end
        end
    end

    initial begin

        // Wait for reset to be de-asserted
        #25;

        // Write ARR array to memory
        uut.dmem.RAM[32] = 32'd3;
        uut.dmem.RAM[33] = 32'd7;
        uut.dmem.RAM[34] = 32'd2;
        uut.dmem.RAM[35] = 32'd6;
        uut.dmem.RAM[36] = 32'd5;
        uut.dmem.RAM[37] = 32'd4;
        uut.dmem.RAM[38] = 32'd1;
        uut.dmem.RAM[39] = 32'd1000;
        uut.dmem.RAM[40] = 32'd999;
        uut.dmem.RAM[41] = 32'd25;
        uut.dmem.RAM[42] = 32'd90;
        uut.dmem.RAM[43] = 32'd100;
        uut.dmem.RAM[44] = 32'd30;
        uut.dmem.RAM[45] = 32'd20;
        uut.dmem.RAM[46] = 32'd10;
        uut.dmem.RAM[47] = 32'd200;
        uut.dmem.RAM[48] = 32'd3300;
        uut.dmem.RAM[49] = 32'd250;
        uut.dmem.RAM[50] = 32'd12;
        uut.dmem.RAM[51] = 32'd75;

        // Write COUNT array to memory
        uut.dmem.RAM[0] = 32'd17;
        uut.dmem.RAM[1] = 32'd13;
        uut.dmem.RAM[2] = 32'd18;
        uut.dmem.RAM[3] = 32'd14;
        uut.dmem.RAM[4] = 32'd15;
        uut.dmem.RAM[5] = 32'd16;
        uut.dmem.RAM[6] = 32'd19;
        uut.dmem.RAM[7] = 32'd1;
        uut.dmem.RAM[8] = 32'd2;
        uut.dmem.RAM[9] = 32'd9;
        uut.dmem.RAM[10] = 32'd6;
        uut.dmem.RAM[11] = 32'd5;
        uut.dmem.RAM[12] = 32'd8;
        uut.dmem.RAM[13] = 32'd10;
        uut.dmem.RAM[14] = 32'd12;
        uut.dmem.RAM[15] = 32'd4;
        uut.dmem.RAM[16] = 32'd0;
        uut.dmem.RAM[17] = 32'd3;
        uut.dmem.RAM[18] = 32'd11;
        uut.dmem.RAM[19] = 32'd7;

        // Zero out RESULT array in memory
        for (i = 0; i < 20; i = i + 1) begin
            uut.dmem.RAM[64 + i] = 32'd0;
        end

        $dumpfile("riscvtest.vcd"); 
        $dumpvars(0, testbench);
    end
endmodule

//iverilog -o riscvtest top.v riscvsingle.v controller.v maindec.v aludec.v datapath.v adder.v extend.v flopr.v flopenr.v mux2.v mux3.v alu.v imem.v regfile.v dmem.v testbench.v
//vvp riscvtest
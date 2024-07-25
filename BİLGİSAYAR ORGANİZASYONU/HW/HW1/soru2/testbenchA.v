`timescale 1ns / 1ps
`include "Datapath.v"

module TestbenchA;

    reg clock = 0;
    reg reset = 1;
    reg register_write;
    reg [1:0] source_reg1_addr, source_reg2_addr, destination_reg_addr;
    reg [2:0] alu_operation;

    always #5 clock = ~clock;

    Datapath dp (
        .clk(clock),
        .reset(reset),
        .srcReg1Addr(source_reg1_addr),
        .srcReg2Addr(source_reg2_addr),
        .destRegAddr(destination_reg_addr),
        .aluOp(alu_operation),
        .regWrite(register_write),
        .aluResult()
    );

    initial begin
        $dumpfile("testbenchA.vcd");
        $dumpvars(0, TestbenchA);
        // Initialize simulation
        #10 reset = 0; register_write = 1;

        // R0 ← R1 + R2
        source_reg1_addr = 1; source_reg2_addr = 2; destination_reg_addr = 0; alu_operation = 3'b000; 
        #10;

        // R1 ← R2 AND R3
        source_reg1_addr = 2; source_reg2_addr = 3; destination_reg_addr = 1; alu_operation = 3'b010;
        #10;

        // R3 ← R2 XOR R0
        source_reg1_addr = 2; source_reg2_addr = 0; destination_reg_addr = 3; alu_operation = 3'b011;
        #10;

        // R2 ← R1 - R3
        source_reg1_addr = 1; source_reg2_addr = 3; destination_reg_addr = 2; alu_operation = 3'b001;
        #10;

        // End simulation
        #10 $finish;
    end
endmodule

`timescale 1ns / 1ps
`include "Datapath.v"

module TestbenchB;

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
        // Initialize simulation
        #10 reset = 0; register_write = 1;

        // The operations to set R1 to 0, R0 to -1, R2 to R1 - 1, and R3 to R0 + 1 require
        // careful manipulation of the ALU operations and register file. 
        // These operations depend highly on the initial values of the registers and 
        // the specific capabilities of your ALU (e.g., ability to directly set a register to 0 or -1)
        // Without knowing the initial state of the registers or the full capabilities of your ALU,
        // providing
    end
endmodule

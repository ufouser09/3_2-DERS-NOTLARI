`timescale 1ns / 1ps
`define WORD_SIZE 32
`include "RegisterFile.v"
`include "ALU.v"
module DatapathModule(
    input clock,
    input reset,
    input [1:0] source_reg1_addr,
    input [1:0] source_reg2_addr,
    input [1:0] destination_reg_addr,
    input [2:0] alu_operation,
    input register_write_enable,
    output [31:0] alu_result
);
    wire [31:0] source_reg1_data;
    wire [31:0] source_reg2_data;
    wire [31:0] write_data;

    // Instantiate Register File Module
    RegisterFile RF (
        .clk(clock),
        .wr(register_write_enable),
        .rst(reset),
        .addr1(source_reg1_addr),
        .addr2(source_reg2_addr),
        .addr3(destination_reg_addr),
        .data3(write_data),
        .data1(source_reg1_data),
        .data2(source_reg2_data)
    );

    // Instantiate ALU Module
    ALU_32bit ALU (
        .A(source_reg1_data),
        .B(source_reg2_data),
        .ALUControl(alu_operation),
        .Result(write_data),
        .Overflow(), // Assuming Overflow handling is not required for this task
        .Zero() // Assuming Zero flag handling is not required for this task
    );

    assign alu_result = write_data;
endmodule

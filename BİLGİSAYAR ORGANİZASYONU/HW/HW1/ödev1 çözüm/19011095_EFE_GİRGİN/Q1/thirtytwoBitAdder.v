`include "fourBitAdder.v"

module ThirtyTwoBitAdder(
    input [31:0] input_num1,
    input [31:0] input_num2,
    output [31:0] output_result,
    output carry_out
);

wire [31:0] sum_result;
wire [31:0] carry_output;

// Using the fourBitAdder module 8 times to perform 32-bit addition
fourBitAdder fba0(input_num1[3:0], input_num2[3:0], sum_result[3:0], carry_output[0]);
fourBitAdder fba1(input_num1[7:4], input_num2[7:4], sum_result[7:4], carry_output[1]);
fourBitAdder fba2(input_num1[11:8], input_num2[11:8], sum_result[11:8], carry_output[2]);
fourBitAdder fba3(input_num1[15:12], input_num2[15:12], sum_result[15:12], carry_output[3]);
fourBitAdder fba4(input_num1[19:16], input_num2[19:16], sum_result[19:16], carry_output[4]);
fourBitAdder fba5(input_num1[23:20], input_num2[23:20], sum_result[23:20], carry_output[5]);
fourBitAdder fba6(input_num1[27:24], input_num2[27:24], sum_result[27:24], carry_output[6]);
fourBitAdder fba7(input_num1[31:28], input_num2[31:28], sum_result[31:28], carry_out);

// Outputting the result
assign output_result = sum_result;

endmodule

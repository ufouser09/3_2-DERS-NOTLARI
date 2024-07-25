`include "onebitadder.v"

// 4-bit full adder module using 1-bit adders
module FullAdder4Bit(input [3:0] operandA, input [3:0] operandB, output [3:0] sumResult, output carryOut);

wire [3:0] interSum; // Intermediate sum results
wire [3:0] interCarry; // Intermediate carry results

// Instantiate one-bit adders for each bit
onebitadder bitAdder1(operandA[0], operandB[0], 0, interSum[0], interCarry[0]);
onebitadder bitAdder2(operandA[1], operandB[1], interCarry[0], interSum[1], interCarry[1]);
onebitadder bitAdder3(operandA[2], operandB[2], interCarry[1], interSum[2], interCarry[2]);
onebitadder bitAdder4(operandA[3], operandB[3], interCarry[2], interSum[3], carryOut);

// Assign the final sum to the result output
assign sumResult = interSum;

endmodule

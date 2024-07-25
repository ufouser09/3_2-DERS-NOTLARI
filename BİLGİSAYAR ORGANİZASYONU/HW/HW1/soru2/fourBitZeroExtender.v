`include "oneBitZeroExtender.v"

// This module extends a 4-bit input to a 32-bit output with zero extension
module ZeroExtender4to32(input [3:0] inputBits, output [31:0] extendedOutput);

    wire [7:0] extendedFirstBit;
    wire [7:0] extendedSecondBit;
    wire [7:0] extendedThirdBit;
    wire [7:0] extendedFourthBit;

    // Extend each bit from the 4-bit input
    OneBitZeroExtender ExtenderBit0 (.in(inputBits[0]), .out(extendedFirstBit));
    OneBitZeroExtender ExtenderBit1 (.in(inputBits[1]), .out(extendedSecondBit));
    OneBitZeroExtender ExtenderBit2 (.in(inputBits[2]), .out(extendedThirdBit));
    OneBitZeroExtender ExtenderBit3 (.in(inputBits[3]), .out(extendedFourthBit));

    // Combine the extended bits into the 32-bit output
    assign extendedOutput = {extendedFourthBit, extendedThirdBit, extendedSecondBit, extendedFirstBit};
endmodule

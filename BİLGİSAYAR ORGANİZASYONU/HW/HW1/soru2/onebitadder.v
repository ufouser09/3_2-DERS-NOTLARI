// Module for a single-bit full adder
module SingleBitFullAdder(input operandA, input operandB, input carryIn, output resultSum, output resultCarry);
    // Calculate the sum - XOR of inputs and carry-in
    assign resultSum = operandA ^ operandB ^ carryIn;
    // Calculate the carry - combination of ANDs of the inputs and carry-in
    assign resultCarry = (operandA & operandB) | (operandA & carryIn) | (operandB & carryIn);
endmodule

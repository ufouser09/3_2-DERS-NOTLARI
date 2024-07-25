`include "fourBitAdder.v" // Including the 4-bit adder module for testing

module Adder4Bit_TB();

    // Testbench signals
    reg [3:0] A_input, B_input;
    wire [3:0] Sum_output;
    wire CarryOut;

    // 4-bit Adder Module Instance
    fourBitAdder adder4bit (
        .num1(A_input),
        .num2(B_input),
        .result(Sum_output),
        .cout(CarryOut)
    );

    // Test Stimulus
    initial begin
        $dumpfile("Adder4Bit_TB.vcd"); // Define the output VCD file
        $dumpvars(0, Adder4Bit_TB); // Dump all variables within the scope
        // Case 1
        A_input = 4'b0001; // Set A_input to 1
        B_input = 4'b0001; // Set B_input to 1
        #10; // Delay of 10 time units
        $display("A_input = %b, B_input = %b, Sum_output = %b, CarryOut = %b", A_input, B_input, Sum_output, CarryOut);

        // Case 2
        A_input = 4'b1100; // Set A_input to 12
        B_input = 4'b0011; // Set B_input to 3
        #10; // Delay of 10 time units
        $display("A_input = %b, B_input = %b, Sum_output = %b, CarryOut = %b", A_input, B_input, Sum_output, CarryOut);

        // More cases can be inserted here
        // Case 3
        A_input = 4'b1110; // Set A_input to 14
        B_input = 4'b0011; // Set B_input to 3
        #10; // Delay of 10 time units
        $display("A_input = %b, B_input = %b, Sum_output = %b, CarryOut = %b", A_input, B_input, Sum_output, CarryOut);

        // Finish the simulation
        $finish;
    end
endmodule

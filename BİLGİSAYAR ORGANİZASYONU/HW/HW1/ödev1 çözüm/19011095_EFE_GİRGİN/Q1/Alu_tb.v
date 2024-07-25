`timescale 1ns / 1ps
`include "Alu.v"
module ALU32_TestBench;

    // Test Parameters
    parameter TEST_WIDTH = 4;
    parameter TEST_MAX = 5;

    // Inputs and Outputs for Test
    reg [TEST_WIDTH-1:0] InputA, InputB;
    reg [2:0] ControlSig;
    wire [TEST_WIDTH-1:0] ALUResult;
    wire FlagZero;
    wire FlagOver;

    // Instantiate the ALU module
    ALU_32bit ALU_unit (
        .A(InputA),
        .B(InputB),
        .ALUControl(ControlSig),
        .Result(ALUResult),
        .Zero(FlagZero),
        .Overflow(FlagOver)
    );

    // Time and State Variables
    integer current_test = 0;

    // Testing Logic
    initial begin
        $dumpfile("ALU32_TestBench.vcd");
        $dumpvars(0, ALU32_TestBench);
        // Loop through tests
        while (current_test < TEST_MAX) begin
            #10; // Timing interval

            // Populate inputs with random values
            InputA = $urandom_range(0, 2**TEST_WIDTH - 1);
            InputB = $urandom_range(0, 2**TEST_WIDTH - 1);
            ControlSig = $urandom_range(0, 5);

            // Display test results
            $display("Test #%0d:", current_test);
            $display("InputA = %d, InputB = %d, ControlSig = %b", InputA, InputB, ControlSig);
            #10; // Timing interval

            // Check the test results
            case (ControlSig)
                3'b000: $display("Addition Result: %d, FlagZero: %b, FlagOver: %b", ALUResult, FlagZero, FlagOver);
                3'b001: $display("Subtraction Result: %d, FlagZero: %b, FlagOver: %b", ALUResult, FlagZero, FlagOver);
                3'b010: $display("AND Result: %d, FlagZero: %b", ALUResult, FlagZero);
                3'b011: $display("XOR Result: %d, FlagZero: %b", ALUResult, FlagZero);
                3'b101: $display("SLT Result: %d, FlagZero: %b", ALUResult, FlagZero);
                default: $display("Default case, Output: %d, FlagZero: %b", ALUResult, FlagZero);
            endcase
            #10; // Timing interval

            // Increment for the next test
            current_test = current_test + 1;
        end

        // Completion of Tests
        $display("All tests completed.");
        $finish;
    end

endmodule

// To compile: iverilog -o ALU32_TestBench.vvp ALU32_TestBench.v

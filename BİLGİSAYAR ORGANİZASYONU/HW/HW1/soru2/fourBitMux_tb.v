`include "fourBitMux.v" // Testing the 4-bit multiplexer module

module Mux4Bit_TestBench();

    // Testbench control and data signals
    reg sigA, sigB, sigC, sigD;
    reg [1:0] sigSelect;
    wire sigOut;

    // Unit Under Test instantiation
    fourBitMux muxUnderTest (
        .a(sigA),
        .b(sigB),
        .c(sigC),
        .d(sigD),
        .select(sigSelect),
        .out(sigOut)
    );

    // Generating stimulus for the tests
    initial begin
        $dumpfile("Mux4Bit_TestBench.vcd"); // Output file for waveform
        $dumpvars(0, Mux4Bit_TestBench); // Dump all the testbench variables
        // Test scenario 1
        sigA = 1'b1; // Set signal A
        sigB = 1'b0; // Set signal B
        sigC = 1'b0; // Set signal C
        sigD = 1'b1; // Set signal D
        sigSelect = 2'b11; // Choose signal D
        #10; // Delay of 10 time units
        $display("sigA = %b, sigB = %b, sigSelect = %b, sigOut = %b", sigA, sigB, sigSelect, sigOut);

        // Test scenario 2
        sigA = 1'b1; // Set signal A
        sigB = 1'b0; // Set signal B
        sigC = 1'b0; // Set signal C
        sigD = 1'b1; // Set signal D
        sigSelect = 2'b10; // Choose signal C
        #10; // Delay of 10 time units
        $display("sigA = %b, sigB = %b, sigSelect = %b, sigOut = %b", sigA, sigB, sigSelect, sigOut);

        // Test scenario 3
        sigA = 1'b1; // Set signal A
        sigB = 1'b0; // Set signal B
        sigC = 1'b0; // Set signal C
        sigD = 1'b1; // Set signal D
        sigSelect = 2'b00; // Choose signal A
        #10; // Delay of 10 time units
        $display("sigA = %b, sigB = %b, sigSelect = %b, sigOut = %b", sigA, sigB, sigSelect, sigOut);
        // More test scenarios can be implemented here

        // Conclude the simulation
        $finish;
    end
endmodule

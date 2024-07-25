`include "oneBitMux.v"

// This module implements a 4-bit multiplexer using one bit multiplexers
module Multiplexer4Bit(output finalOutput, input inputA, input inputB, input inputC, input inputD, input [1:0] selectorBits);
    // Input and selector bits
    input inputA, inputB, inputC, inputD;
    input [1:0] selectorBits; // 2-bit selection input
    output finalOutput; // Final output after selection

    wire firstStageOutput1, firstStageOutput2; // Wires for the outputs of the first stage muxes

    // First stage 2x1 multiplexers
    oneBitMux stage1Mux1( // stage1Mux1 selects between inputA and inputB
        .out(firstStageOutput1),
        .a(inputA),
        .b(inputB),
        .select(selectorBits[1])
    );

    oneBitMux stage1Mux2( // stage1Mux2 selects between inputC and inputD
        .out(firstStageOutput2),
        .a(inputC),
        .b(inputD),
        .select(selectorBits[1])
    );

    // Second stage 2x1 multiplexer
    oneBitMux finalStageMux( // finalStageMux selects between the outputs of the first stage muxes
        .out(finalOutput),
        .a(firstStageOutput1),
        .b(firstStageOutput2),
        .select(selectorBits[0])
    );
endmodule

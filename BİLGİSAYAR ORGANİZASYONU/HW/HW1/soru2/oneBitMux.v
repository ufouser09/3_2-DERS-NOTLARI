// Module for a one-bit multiplexer
module BitMux(output muxOut, input muxIn1, input muxIn2, input muxSelect);
    // Define inputs and output
    input muxIn1, muxIn2, muxSelect;
    output muxOut;
    // Assign the output based on the select signal
    assign muxOut = (~muxSelect & muxIn2) | (muxSelect & muxIn1);
endmodule

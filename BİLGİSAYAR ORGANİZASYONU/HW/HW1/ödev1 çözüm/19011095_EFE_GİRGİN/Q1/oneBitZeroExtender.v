module ZeroExtender(
    input input_signal,
    output [31:0] output_signal
);
//wire [31:0] temp_variable;
   assign output_signal = {31'b0, input_signal}; // Extends the input with 31 zero bits
endmodule

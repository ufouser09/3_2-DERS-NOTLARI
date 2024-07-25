`include "thirtytwoBitAdder.v"
`include "fourBitMux.v"
`include "oneBitZeroExtender.v"

module ArithmeticLogicUnit (
    input [31:0] Operand1, // 32-bit input Operand1
    input [31:0] Operand2, // 32-bit input Operand2
    input [2:0] ControlSignal, // 3-bit ALU control signal
    output reg [31:0] ALUOutput, // 32-bit ALU output
    output wire ZeroFlag, // Zero flag (1 if result is 0, otherwise 0)
    output reg CarryOut // Carry out flag
);

    wire [31:0] sum_result;
    wire [31:0] difference_result;
    wire [31:0] conjunction_result;
    wire [31:0] exclusiveOr_result;
    wire setOnLessThan_result;
    wire [31:0] zeroExtended;
    wire extensionBit;
    wire carryOutSignal;
    
    assign extensionBit = CarryOut ^ sum_result[31];
    OneBitZeroExtender extender_module(.in(extensionBit), .out(zeroExtended));
    thirtyTwoBitAdder addition_module(.num1(Operand1), .num2(Operand2), .result(sum_result), .cout);

    thirtyTwoBitAdder subtraction_module(.num1(Operand1),.num2(~Operand2 + 1),.result(difference_result),.cout());

    assign conjunction_result = Operand1 & Operand2;
    assign exclusiveOr_result = Operand1 ^ Operand2;
    assign setOnLessThan_result = (Operand1 < Operand2);

    // Perform ALU operations based on ControlSignal
    always @(*)
        case (ControlSignal)
            3'b000: begin
                ALUOutput = sum_result; // Addition operation
                CarryOut = ((~(ControlSignal[0] ^ Operand2[31] ^ Operand1[31])) & (Operand1[31] ^ ALUOutput[31]) & (~ControlSignal[1]));
            end
            3'b001: begin 
                ALUOutput = difference_result; // Subtraction operation
                CarryOut = ((~(ControlSignal[0] ^ Operand2[31] ^ Operand1[31])) & (Operand1[31] ^ ALUOutput[31]) & (~ControlSignal[1]));
            end
            3'b010: begin
                ALUOutput = conjunction_result; // AND operation
            end
            3'b011:begin
                ALUOutput = exclusiveOr_result; // XOR operation
            end
            3'b101:begin  
                ALUOutput = zeroExtended; // Set on less than operation
            end
            default:begin
                CarryOut=0;
                ALUOutput = 0; // Default case (no operation)
            end
        endcase

    // Set the Zero flag
    assign ZeroFlag = (ALUOutput == 0);

endmodule

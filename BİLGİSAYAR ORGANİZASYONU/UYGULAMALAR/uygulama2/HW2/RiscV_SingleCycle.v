module RiscV_SingleCycle(
    input clk,
    input reset,
    output reg [31:0] pc,
    input [31:0] instruction,
    output reg [31:0] alu_result,
    output [31:0] write_data,
    input [31:0] read_data
);

    // PC register and Next PC logic
    reg [31:0] next_pc;

    always @(posedge clk or posedge reset) begin
        if (reset) 
            pc <= 32'b0;
        else 
            pc <= next_pc;
    end

    // Instruction Decode
    wire [6:0] opcode;
    wire [4:0] rd, rs1, rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [31:0] sign_extended_imm;

    assign opcode = instruction[6:0];
    assign rd = instruction[11:7];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];
    assign sign_extended_imm = 32'sd123; 

    // Register File
    reg [31:0] registers[31:0];
    always @(posedge clk) begin
        if (!reset && instruction[5:0] != 6'b000000 && opcode != 7'b1101111)
            registers[rd] <= alu_result;  // Write back to the register file, exclude jal
    end
    assign write_data = registers[rd];

    wire [31:0] rs1_data = registers[rs1];
    wire [31:0] rs2_data = registers[rs2];

    // ALU
    reg [31:0] alu_out;

    always @(*) begin
        case (opcode)
            7'b0110011: begin  // R-type
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0000000)
                            alu_out = rs1_data + rs2_data;  // ADD
                        else if (funct7 == 7'b0100000)
                            alu_out = rs1_data - rs2_data;  // SUB
                    end
                    3'b101: begin
                        if (funct7 == 7'b0000000)
                            alu_out = rs1_data >> rs2_data[4:0];  // Logical shift right (SRL)
                        else if (funct7 == 7'b0100000)
                            alu_out = $signed(rs1_data) >>> rs2_data[4:0];  // Arithmetic shift right (SRA)
                    end
                    3'b110: alu_out = rs1_data | rs2_data;  // OR
                    3'b111: alu_out = rs1_data & rs2_data;  // AND
                    3'b010: alu_out = ($signed(rs1_data) < $signed(rs2_data)) ? 1 : 0;  // SLT
                endcase
            end
            7'b0000011: alu_out = rs1_data + sign_extended_imm; // LW
            7'b0100011: alu_out = rs1_data + sign_extended_imm; // SW
            7'b0010011: begin  // I-type ALU operations
                case (funct3)
                    3'b000: alu_out = rs1_data + sign_extended_imm;  // ADDI
                    3'b110: alu_out = rs1_data | sign_extended_imm;  // ORI
                    3'b111: alu_out = rs1_data & sign_extended_imm;  // ANDI
                    3'b010: alu_out = ($signed(rs1_data) < $signed(sign_extended_imm)) ? 1 : 0;  // SLTI
                endcase
            end
        endcase
    end

    // Data Memory Interaction
    always @(posedge clk) begin
        if (opcode == 7'b0000011)  // LW
            alu_result <= read_data;

        else
            alu_result <= alu_out;
    end

    // Initialize next_pc
    always @(posedge clk or posedge reset) begin
        if (reset)
            next_pc <= 32'b0;
        else if (opcode != 7'b1100011 && opcode != 7'b1101111)
            next_pc <= pc + 4;  // Default increment
        else if (opcode == 7'b1101111)
            next_pc <= pc + sign_extended_imm; //JAL
    end

endmodule

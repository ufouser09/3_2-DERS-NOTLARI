module TestBench;

    reg clk = 0;
    reg reset = 0;
    wire [31:0] pc;
    wire [31:0] alu_result;
    wire [31:0] write_data;
    reg [31:0] instruction;
    reg [31:0] read_data;

    RiscV_SingleCycle dut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .alu_result(alu_result),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = !clk;  // Clock generation

    initial begin
        $dumpfile("processor_sim.vcd");
        $dumpvars(0, TestBench);

        reset = 1;
        #10;
        reset = 0;

        // Initialize register values (example: R10 = 5, R11 = 4, R12 = 3)
        dut.registers[10] = 5;  // R10
        dut.registers[11] = 4;  // R11
        dut.registers[12] = 3;  // R12
        read_data = 123;  // Simulate read data for LW

        // ADD R8, R10, R11
        instruction = 32'b0000000_01011_01010_000_01000_0110011;
        #10;
        // OR R8, R10, R11
        instruction = 32'b0000000_01011_01010_110_01000_0110011;
        #10;
        // AND R8, R10, R11
        instruction = 32'b0000000_01011_01010_111_01000_0110011;
        #10;
        // SLT R8, R10, R11
        instruction = 32'b0000000_01011_01010_010_01000_0110011;
        #10;
        // ADDI R8, R10, #9 (Immediate Add)
        instruction = 32'b00000000000001010_000_01000_0010011;  // imm[11:0] rs1 funct3 rd opcode
        #10;
        // SLTI R8, R10, #7 (Set less than immediate)
        instruction = 32'b00000000000001010_010_01000_0010011;
        #10;
        // ANDI R8, R10, #15 (AND immediate)
        instruction = 32'b00000000000001010_111_01000_0010011;
        #10;
        // ORI R8, R10, #12 (OR immediate)
        instruction = 32'b00000000000001010_110_01000_0010011;
        #10;
        // LW R8, 4(R10) (Load word)
        instruction = 32'b00000000010001010_010_01000_0000011;  // imm[11:0] rs1 funct3 rd opcode
        #10;
        // SW R8, 4(R10) (Store word)
        instruction = 32'b00000000010001000_010_01010_0100011;  // imm[11:5] rs2 rs1 funct3 imm[4:0] opcode
        #10;
        // Testing JAL: should jump to address PC + 16 and set R8 to the next instruction address (PC + 4)
        instruction = 32'b00000000000100000_00000_000_01000_1101111;  // imm[20] imm[10:1] imm[11] imm[19:12] rd opcode
        #20;  // Need more time for jump to be visible
        // Testing BEQ: Should branch if R10 equals R11
        instruction = 32'b0000000_01011_01010_000_00000_1100011;  // imm[12:1] rs2 rs1 funct3 imm[11] imm[12] opcode
        #10;
        // Instruction after BEQ, should not execute if branch taken
        instruction = 32'b0000000_01100_01010_000_01000_0110011;  // ADD R8, R10, R12 (Should not execute if BEQ takes)
        #10;

        // Testing SRA: Shift Right Arithmetic
        dut.registers[10] = 32'hFFFFF830;  // Negative number to demonstrate sign extension
        dut.registers[11] = 4;             // Shift by 4 bits
        instruction = 32'b0100000_01011_01010_101_01000_0110011;  // SRA R8, R10, R11
        #10;

        $finish;  // Ends the simulation
    end

endmodule

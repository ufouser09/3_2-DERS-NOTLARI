`timescale 1ns / 1ps
`include "Q1.v"
`include "regfile.v"

module testbench;
    // Define signals for inputs and outputs
    reg clk = 0;
    reg wr = 0;
    reg [1:0] addr1, addr2, addr3;
    reg [2:0] ALUControl;
    wire [31:0] data1, data2;
    reg [31:0] data3;
    wire [31:0] ALUResult;
    wire Zero, Overflow;

    // Instantiate the modules
    regfile RF (.addr1(addr1), .addr2(addr2), .addr3(addr3), 
               .data1(data1), .data2(data2), .data3(data3), 
               .clk(clk), .wr(wr), .rst(1'b0));

    ALU_32bit ALU (.A(data1), .B(data2), .ALUControl(ALUControl), 
                   .Result(ALUResult), .Zero(Zero), .Overflow(Overflow));

    // Generate clock signal
    always #10 clk = ~clk;

    // Test sequence
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);
        
        // Initialize registers with specific values
        writeRegister(0, 10);  // R0 ← 10
        writeRegister(1, 5);   // R1 ← 5
        writeRegister(2, 0);   // R2 ← 0
        writeRegister(3, 1);   // R3 ← 1

        // Perform operations for part a
        performALUOperation(1, 2, 0, 3'b000); // R0 ← R1 + R2
        performALUOperation(2, 3, 1, 3'b010); // R1 ← R2 AND R3
        performALUOperation(2, 0, 3, 3'b011); // R3 ← R2 XOR R0
        performALUOperation(1, 3, 2, 3'b001); // R2 ← R1 - R3

        // Perform operations for part b
              // R1'e 0 değeri yaz (R1 sıfırlanıyor)
        writeRegister(1, 0);

        // R0'a -1 değeri yaz (32 bit için 0xFFFFFFFF)
        writeRegister(0, 32'hFFFFFFFF);

        // R1'den 1 çıkararak R2'yi hesapla (R1 şu anda 0)
        // Önce 1 değerini bir kayıta yaz
        writeRegister(3, 1); //R3'e 1 yazıyoruz 
        performALUOperation(1, 3, 2, 3'b001); // R2 ← R1 - 1

        // R0 + 1 hesapla ve R3'e yaz (R0 şu anda -1)
        writeRegister(3, 1); // R3'e 1 yazılıyor ve bu değer toplamak için kullanılacak
        performALUOperation(0, 3, 3, 3'b000); // R3 ← R0 + 1

        #100 $finish;
    end

    task writeRegister;
        input [1:0] regAddr;
        input [31:0] value;
        begin
            addr3 = regAddr; data3 = value; wr = 1; #20; wr = 0; #10;
            $display("Register R%0d written with value: %h", regAddr, value);
        end
    endtask

    task performALUOperation;
        input [1:0] srcAddr1; input [1:0] srcAddr2; input [1:0] destAddr; input [2:0] control;
        begin
            addr1 = srcAddr1; addr2 = srcAddr2; addr3 = destAddr; ALUControl = control;
            #40; // Allow time for ALU to compute
            wr = 1; #20; wr = 0; #20; // Trigger write to register
            $display("ALU Operation (Control: %b) Result: %h written to R%0d", control, ALUResult, destAddr);
        end
    endtask
endmodule
`include "regfile.v"
`include "soru1.v"

module question2Answer();
    reg [2:0] alucontrol; // ALU kontrol sinyali
    wire [31:0] result; // ALU'nun çıkışı
    wire cout; // Taşıma çıkışı
    wire [31:0] data1, data2; // Register File'dan okunan veriler
    wire [31:0] data3; // Register File'a yazılacak veri
    reg clk, wr, rst; // Saat, yazma işlemi ve reset kontrol sinyalleri
    reg [1:0] addr1, addr2, addr3; // Register File adresleri
    
    // Register File modülünün çağrılması ve bağlantıların yapılması

    regfile regfile (
        .addr1(addr1),
        .addr2(addr2),
        .addr3(addr3),
        .data1(data1),
        .data2(data2),
        .data3(result),
        .clk(clk),
        .wr(wr),
        .rst(rst)
    );

    // ALU modülünün çağrılması ve bağlantıların yapılması
    alu_32bit alu (
        .result(result),
        .cout(cout),
        .a(data1),
        .b(data2),
        .alucontrol(alucontrol)
    );
    
    initial begin
        clk = 0; // Saat sinyali başlangıçta 0
        wr = 1; // Yazma işlemi başlangıçta etkin
        rst = 0; // Reset başlangıçta etkin değil
    end

    // Question 2-a
    initial begin
        // R0 ← R1 + R2
        alucontrol = 3'b000; addr1 = 2'b01; addr2 = 2'b10; #10; // ALU kontrol sinyali, ve Register File adresleri belirlenir
        addr3 = 2'b00; clk = 1; // Register File'da yazma işlemi için saat sinyali yükseltilir
        clk = 0; // Saat sinyali düşürülür
        // R1 ← R2 AND R3
        alucontrol = 3'b010; addr1 = 2'b10; addr2 = 2'b11; #10; 
        addr3 = 2'b01; clk = 1; 
        clk = 0; // Saat sinyali düşürülür
        // R3 ← R2 XOR R0
        alucontrol = 3'b011; addr1 = 2'b10; addr2 = 2'b00; #10; 
        addr3 = 2'b11; clk = 1; 
        clk = 0; 
        // R2 ← R1 - R3 
        alucontrol = 3'b001; addr1 = 2'b01; addr2 = 2'b11; #10; 
        addr3 = 2'b10; clk = 1; 
        clk = 0; 
        #10;

        // Question 2-b
        //  R1 ← 0  =>  R1 ← R1 - R1
        alucontrol = 3'b001; addr1 = 2'b01; addr2 = 2'b01; #10; // ALU kontrol sinyali, ve Register File adresleri belirlenir
        addr3 = 2'b01; clk = 1; // Register File'da yazma işlemi için saat sinyali yükseltilir
        clk = 0; // Saat sinyali düşürülür
        // R0 ← -1  => R1 - R3
        alucontrol = 3'b001; addr1 = 2'b01; addr2 = 2'b11; #10; 
        addr3 = 2'b00; clk = 1; 
        clk = 0; 
        // R2 ← R1 – 1 => R2 ← R1 + R0
        alucontrol = 3'b000; addr1 = 2'b01; addr2 = 2'b00; #10; 
        addr3 = 2'b10; clk = 1; 
        clk = 0; 
        //  R3 ← R0 + 1 => R3 ← R0 - R0
        alucontrol = 3'b001; addr1 = 2'b00; addr2 = 2'b00; #10; 
        addr3 = 2'b11; clk = 1; 
        clk = 0; 
        #10;
    end
    
    // Sonuçların gösterilmesi için izleme
    initial begin
        $monitor("result = %b, a = %b, b = %b, Time = %t", result, alu.a, alu.b, $time);
    end

    // VCD dosyasına veri yazmak için
    initial begin
        $dumpfile("Soru2.vcd");
        $dumpvars(0, Soru2);
    end

endmodule

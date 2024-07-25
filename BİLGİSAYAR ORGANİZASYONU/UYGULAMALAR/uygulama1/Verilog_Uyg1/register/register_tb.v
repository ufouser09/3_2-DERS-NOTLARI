

`timescale 1ns / 1ps//Bu satır, zaman birimlerinin tanımlandığı timescale yönergesidir. Burada, 1 nanosaniye (1ns) için 1 pikosaniye (1ps) kullanılmaktadır.
`include "register.v"//Bu satır, test bench kodunda kullanılacak register modülünün (register.v dosyasındaki modül) içeriğini dahil eder.
module register_tb;//Bu satır, test bench modülünü tanımlar.

    //Bu satırlar, test bench için giriş ve çıkışları tanımlar. A dört bitlik bir giriş verisini, clk bir saat sinyalini temsil ederken, q0, q1, q2, q3 ise dört farklı çıkış bitini temsil eder.
    reg [3:0] A;
    reg clk;
    wire q0, q1, q2, q3;

//Bu satır, register modülünden (register.v dosyasındaki modül) bir örnek oluşturur ve uut adını verir. Bu örneğe, A, clk ve q0, q1, q2, q3 sinyallerini bağlar.
    register uut (
        .A(A),
        .clk(q0),
        .q1(q1),
        .q2(q2),
        .q3(q3)
    );

    // Clock
    //Bu blok, clk sinyalinin her 5 zaman birimi (5ns) için bir önceki değerinin tersini almasını sağlar. Böylece, clk sinyali düzenli olarak değişir ve simülasyon süresince saat sinyali sağlanır.
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
//Bu blok, simülasyonun başlangıcında A giriş verisine değerler atanır. Ardından, belirli zaman aralıklarında A'nın değeri değiştirilir. Her bir değer değişimi, #10 zaman birimi (10ns) beklenir. Simülasyon sona erdiğinde, $finish komutuyla simülasyon sonlandırılır.
    initial begin
        A = 4'b0000;
        #10;
        
        A = 4'b1010; #10;
        A = 4'b1100; #10;
        A = 4'b0011; #10;

        $finish;
    end
//Bu blok, simülasyon sırasında değişken değerlerini bir VCD dosyasına kaydetmek için $dumpfile ve $dumpvars komutlarını kullanır. Böylece, simülasyon sonucunda değişkenlerin değerleri analiz edilebilir hale gelir.
    initial begin
        $dumpfile("register_tb.vcd");
        $dumpvars(0, register_tb);
        #0;
    end
    
endmodule//Bu satır, test bench modülünün tanımını sonlandırır.

//Son olarak, yorum satırlarında gösterildiği gibi, kodun derlenmesi (iverilog -o register_tb.vvp register_tb.v), çalıştırılması (vvp register_tb.vvp) ve simülasyon sonuçlarının görselleştirilmesi (gtkwave) adımları gerçekleştirilir. Bu adımlar, simülasyon sonuçlarını analiz etmek ve doğrulamak için kullanılır.
//iverilog -o register_tb.vvp register_tb.v
//vvp register_tb.vvp
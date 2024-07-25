
`include "counter.v"
//Bu kod, counter.v dosyasında tanımlanan sayıcı modülünün test benchesini (test bankosunu) içerir. Test benches, bir donanım modülünün doğru çalışıp çalışmadığını kontrol etmek için kullanılır. İşte kodun Türkçe açıklaması:
//Bu satır, counter.v dosyasının içeriğini bu test bench dosyasına dahil eder. Bu dosya, 4-bitlik bir ikili sayıcı modülünü içerir ve bu test benchinde kullanılır.

module counter_tb;//Bu satır, test bench modülünü tanımlar.

    
    // Inputs
    reg CLK, RESET, EN;//Bu satırlar, test bench için giriş ve çıkışları tanımlar. CLK, RESET ve EN girişleri, sayıcı modülü için kontrol sinyallerini temsil eder. Q, 4-bitlik sayıcı çıkışını temsil ederken, CO ise taşıma çıkışını temsil eder.
    
    // Outputs
    wire [3:0] Q;
    wire CO;

    counter uut (//Bu satır, counter modülünden (counter.v dosyasındaki modül) bir örnek oluşturur ve uut adını verir. Bu örneğe, CLK, RESET, EN, Q ve CO sinyallerini bağlar.

        .CLK(CLK),
        .RESET(RESET),
        .EN(EN),
        .Q(Q),
        .CO(CO)
    );
    
    initial begin
        //Bu blok, simülasyonun başlangıcını belirtir. $dumpfile ve $dumpvars, simülasyon sırasında değişken değerlerini bir VCD dosyasına kaydetmek için kullanılır. Ardından, RESET, EN ve CLK sinyalleri başlangıç değerleriyle başlatılır. Belirli bir süre geçtikten sonra (#30), sıfırlama işlemi gerçekleşir (RESET = 1'b1). Bir süre daha bekledikten sonra (#10), sıfırlama işlemi sonlandırılır (RESET = 1'b0). Ardından, sayıcının etkinleştirilmesi ve devre dışı bırakılması gerçekleşir. Simülasyon sona erdirilir ($finish).
        $dumpfile("counter_tb.vcd");
        $dumpvars(0, counter_tb);
        
        RESET = 1'b0;
        EN = 1'b1;
        CLK= 1'b0;
    
        #30; 
        
        // Reset
        RESET = 1'b1;
        #10; 
        RESET = 1'b0;
        #50; 
        
        RESET = 1'b0;
        EN = 1'b0; // Disable counter
    
        #30;
  
        $finish;
    end
    always #5 CLK=~CLK;//Bu satır, CLK sinyalinin her 5 zaman biriminde bir (5 time unit) negatif kenar (CLK = ~CLK) almasını sağlar. Böylece, CLK sinyali düzenli olarak değişir ve simülasyon daha gerçekçi hale gelir.
endmodule//Bu satır, test bench modülünün tanımını sonlandırır.

// iverilog -o counter_tb.vvp counter_tb.v
// vvp counter_tb.vvp
// gtkwave
//Son olarak, yorum satırlarında gösterildiği gibi, kodun derlenmesi (iverilog -o counter_tb.vvp counter_tb.v), çalıştırılması (vvp counter_tb.vvp) ve simülasyon sonuçlarının görselleştirilmesi (gtkwave) adımları gerçekleştirilir. Bu adımlar, simülasyon sonuçlarını analiz etmek ve doğrulamak için kullanılır.

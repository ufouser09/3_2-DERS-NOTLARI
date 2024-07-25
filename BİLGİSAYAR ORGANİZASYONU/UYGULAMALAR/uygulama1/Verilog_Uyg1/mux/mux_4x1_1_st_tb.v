
`include "mux_4x1_1_st.v"
//Bu satır, test bench kodunda kullanılacak olan mux_4x1_1_st modülünün (mux_4x1_1_st.v dosyasındaki modül) içeriğini bu kod dosyasına dahil eder.

module mux_4x1_1_st_tb;
//Bu satır, test bench modülünü tanımlar.


//Bu satırlar, test bench için giriş ve çıkış sinyallerini tanımlar. a, b, c ve d girişleri, çoklanacak 1 bitlik sinyalleri temsil ederken, select girişi seçimi kontrol eden 2 bitlik bir sinyaldir. out, çoklanmış çıkışı temsil eder. reg veri türü, bu sinyallerin bellek değerlerini tutar.
reg a, b, c, d;
reg [1:0] select;
wire out;

// 4x1
//Bu satır, mux_4x1_1_st modülünden bir örnek oluşturur ve uut adını verir. Bu örneğe, out, a, b, c, d ve select sinyallerini bağlar.
mux_4x1_1_st uut (
    .out(out), 
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d), 
    .select(select)
);

//Bu blok, test senaryolarını içerir. Giriş sinyalleri başlangıç değerleri ile başlatılır, belirli bir süre beklenir ve ardından seçim sinyalleri değiştirilir. Bu adımlar, modülün farklı giriş kombinasyonlarına nasıl tepki verdiğini kontrol etmek için kullanılır.
initial begin
    
    a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; select = 00;
    
    #10; a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; select = 2'b00; // d
    #10; a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; select = 2'b01; // b
    #10; a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; select = 2'b10; // c
    #10; a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b0; select = 2'b11; // a

    
    #10; $finish;
end

//Bu blok, giriş ve çıkış sinyallerini ekrana yazdırmak için bir $monitor komutu kullanır. Herhangi bir giriş veya çıkış sinyali değiştiğinde, bu blok çalışır ve ilgili değerler ekrana yazdırılır.
initial begin
    $monitor("Time = %t, select = %b, a = %b, b = %b, c = %b, d = %b, out = %b", $time, select, a, b, c, d, out);
end

//Bu blok, simülasyon sırasında değişken değerlerini bir VCD dosyasına kaydetmek için $dumpfile ve $dumpvars komutlarını kullanır. Böylece, simülasyon sonucunda değişkenlerin değerleri analiz edilebilir hale gelir.
initial begin
        $dumpfile("mux_4x1_1_st_tb.vcd");
        $dumpvars(0, mux_4x1_1_st_tb);
    end

endmodule
//Bu satır, test bench modülünün tanımını sonlandırır.

//iverilog -o mux_4x1_1_st_tb.vvp mux_4x1_1_st_tb.v
//vvp mux_4x1_1_st_tb.vvp


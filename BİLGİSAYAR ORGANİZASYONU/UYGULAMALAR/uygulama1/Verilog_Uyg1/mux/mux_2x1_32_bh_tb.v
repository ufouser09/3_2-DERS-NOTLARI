`timescale 1ns/1ns
//Bu satır, simülasyon zaman ölçeğini belirtir. Burada, bir zaman birimi 1 nanosaniye (1ns) ve zamana bağlı birimler için çözünürlük de 1 nanosaniye (1ns) olarak ayarlanmıştır.

`include "mux_2x1_32_bh.v"
//Bu satır, test bench kodunda kullanılacak olan mux_2x1_32_bh modülünün (mux_2x1_32_bh.v dosyasındaki modül) içeriğini bu kod dosyasına dahil eder.


module mux_2x1_32_bh_tb;//Bu satır, test bench modülünü tanımlar.

    //Bu satırlar, test bench için giriş sinyallerini tanımlar. a ve b girişleri, çoklanacak 32 bitlik sinyalleri temsil ederken, select girişi, seçimi kontrol eden 1 bitlik sinyali temsil eder. reg veri türü, bu sinyallerin bellek değerlerini tutar.
    reg [31:0] a, b;
    reg select;

    //Bu satır, test bench için çıkış sinyalini tanımlar. out, çoklanmış 32 bitlik çıkışı temsil eder. wire veri türü, bu sinyalin değerini temsil eder.
    wire [31:0] out;

    //Bu satır, mux_2x1_32_bh modülünden bir örnek oluşturur ve UUT adını verir. Bu örneğe, out, a, b ve select sinyallerini bağlar.
    mux_2x1_32_bh UUT (
        .out(out),
        .a(a),
        .b(b),
        .select(select)
    );

    //Bu blok, test senaryosunu içerir. Giriş sinyalleri başlangıç değerleri ile başlatılır, belirli bir süre beklenir ve ardından seçim sinyali değiştirilir. Bu adımlar, modülün farklı giriş kombinasyonlarına nasıl tepki verdiğini kontrol etmek için kullanılır.
    initial begin

        a = 32'hABCDEFF0;
        b = 32'h12345678;
        select = 1'b0;
        #10;
        select = 1'b1;
        #10;
        $finish;
    end

    // Display outputs
    //Bu blok, çıkış sinyallerini ekrana yazdırmak için bir always bloğu oluşturur. Herhangi bir giriş sinyali değiştiğinde, bu blok çalışır ve ilgili değerler ekrana yazdırılır.
    always @* begin
        $display("Input a: %h, Input b: %h, Select: %b, Output: %h", a, b, select, out);
    end

//Bu blok, simülasyon sırasında değişken değerlerini bir VCD dosyasına kaydetmek için $dumpfile ve $dumpvars komutlarını kullanır. Böylece, simülasyon sonucunda değişkenlerin değerleri analiz edilebilir hale gelir.

initial begin
        $dumpfile("mux_2x1_32_bh_tb.vcd");
        $dumpvars(0, mux_2x1_32_bh_tb);
    end

//Bu satır, test bench modülünün tanımını sonlandırır.
endmodule

//iverilog -o mux_2x1_32_bh_tb.vvp mux_2x1_32_bh_tb.v
//vvp mux_2x1_32_bh_tb.vvp
//Son olarak, yorum satırlarında gösterildiği gibi, kodun derlenmesi (iverilog -o mux_2x1_32_bh_tb.vvp mux_2x1_32_bh_tb.v), çalıştırılması (vvp mux_2x1_32_bh_tb.vvp) ve simülasyon sonuçlarının görselleştirilmesi (gtkwave) adımları gerçekleştirilir. Bu adımlar, simülasyon sonuçlarını analiz etmek ve doğrulamak için kullanılır.
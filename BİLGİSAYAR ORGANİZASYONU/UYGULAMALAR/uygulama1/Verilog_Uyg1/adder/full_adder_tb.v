/* Test bench for full_adder.v */
//Bu kod, full_adder.v dosyasındaki tam toplayıcı modülünü test etmek için bir test bench (test bankosu) içerir. Test benches, tasarlanan donanım modülünün doğru çalışıp çalışmadığını doğrulamak için kullanılır. İşte kodun Türkçe açıklaması:


`include "full_adder.v"//Bu satır, full_adder.v dosyasının içeriğini bu test bench dosyasına dahil eder. Bu dosya, tam toplayıcı modülünü içerir ve bu test benchinde kullanılır.

module full_adder_tb;//Bu satır, test bench modülünü tanımlar.
    reg a, b, cin;//Bu satırlar, test bench için giriş ve çıkışlarını tanımlar. a, b ve cin girişleri, tam toplayıcı modülü için üç bitlik girişlerdir. sum ve cout ise toplam sonucu ve taşıma çıkışını temsil eden çıkışlardır.
    wire sum, cout;

    full_adder add1(a, b, cin, sum, cout);//Bu satır, full_adder modülünden bir örnek oluşturur ve add1 adını verir. Bu örneğe, a, b ve cin girişlerini bağlar ve sum ve cout çıkışlarını alır.

    initial//Bu blok, simülasyonun başlangıcında çalışır. $dumpfile ve $dumpvars, simülasyon sırasında değişken değerlerini bir VCD dosyasına kaydetmek için kullanılır. a, b ve cin değerleri farklı kombinasyonlarla değiştirilir ve her kombinasyondan sonra 1 zaman birimi beklenir (#1). Bu şekilde, tüm giriş kombinasyonları test edilir.
        begin
            $dumpfile("full_adder.vcd");
            $dumpvars(0, full_adder_tb);
            a = 0; b = 0; cin = 0; #1
            a = 0; b = 0; cin = 1; #1
            a = 0; b = 1; cin = 0; #1
            a = 0; b = 1; cin = 1; #1
            a = 1; b = 0; cin = 0; #1
            a = 1; b = 0; cin = 1; #1
            a = 1; b = 1; cin = 0; #1
            a = 1; b = 1; cin = 1;
        end
endmodule//Bu satır, test bench modülünün tanımını sonlandırır.

//iverilog -o full_adder_tb.vvp full_adder_tb.v
//vvp full_adder_tb.vvp

//Yani, bu test bench, tam toplayıcı modülünün farklı giriş kombinasyonlarını test eder ve çıkışların doğru olup olmadığını kontrol eder. Sonuçlar, VCD dosyasına kaydedilir ve daha sonra görselleştirilerek incelenebilir.
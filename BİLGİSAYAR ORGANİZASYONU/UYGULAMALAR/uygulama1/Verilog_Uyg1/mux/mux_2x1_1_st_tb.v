
`include "mux_2x1_1_st.v"//Bu satır, test bench kodunda kullanılacak olan mux_2x1_1_st modülünün (mux_2x1_1_st.v dosyasındaki modül) içeriğini bu kod dosyasına dahil eder.
//Bu kod, mux_2x1_1_st modülünün test bench'ini oluşturur. Test bench'ler, tasarlanan donanım modüllerinin işlevselliğini doğrulamak için kullanılır. İşte kodun detaylı açıklaması:


//Bu satır, test bench modülünü tanımlar.

module mux_2x1_1_st_tb();

    reg a, b, select;//Bu satır, test bench için giriş sinyallerini tanımlar. a, b ve select girişleri, çoklanacak sinyalleri ve seçim sinyalini temsil eder.


    wire out;//Bu satır, test bench için çıkış sinyalini tanımlar. out, çoklanmış çıkışı temsil eder.
    
    //Bu satır, mux_2x1_1_st modülünden bir örnek oluşturur ve UUT adını verir. Bu örneğe, out, a, b ve select sinyallerini bağlar.
    mux_2x1_1_st UUT(
        .out(out),
        .a(a),
        .b(b),
        .select(select)
    );
    
    //Bu blok, test senaryolarını içerir. Her bir senaryo için select, a ve b giriş sinyallerine farklı değerler atanır. Ardından, belirli bir süre beklenir ve çıkış sinyali olan out değeri görüntülenir. Bu, modülün farklı giriş kombinasyonlarına nasıl tepki verdiğini kontrol etmek için kullanılır.
    initial begin
        select = 0; a = 0; b = 0;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        select = 1; a = 0; b = 0;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        select = 0; a = 0; b = 1;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        select = 1; a = 0; b = 1;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        select = 0; a = 1; b = 0;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        select = 1; a = 1; b = 0;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        select = 0; a = 1; b = 1;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        select = 1; a = 1; b = 1;
        #10 $display("select=%b a=%b b=%b out=%b", select, a, b, out);
        
        #10 $finish;
    end

//Bu blok, simülasyon sırasında değişken değerlerini bir VCD dosyasına kaydetmek için $dumpfile ve $dumpvars komutlarını kullanır. Böylece, simülasyon sonucunda değişkenlerin değerleri analiz edilebilir hale gelir.

initial begin
        $dumpfile("mux_2x1_1_st_tb.vcd");
        $dumpvars(0, mux_2x1_1_st_tb);
    end

endmodule

//Son olarak, yorum satırlarında gösterildiği gibi, kodun derlenmesi (iverilog -o mux_2x1_1_st_tb.vvp mux_2x1_1_st_tb.v), çalıştırılması (vvp mux_2x1_1_st_tb.vvp) ve simülasyon sonuçlarının görselleştirilmesi (gtkwave) adımları gerçekleştirilir. Bu adımlar, simülasyon sonuçlarını analiz etmek ve doğrulamak için kullanılır.
//iverilog -o mux_2x1_1_st_tb.vvp mux_2x1_1_st_tb.v
//vvp mux_2x1_1_st_tb.vvp
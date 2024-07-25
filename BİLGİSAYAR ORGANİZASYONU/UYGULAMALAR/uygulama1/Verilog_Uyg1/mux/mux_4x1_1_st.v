`include "mux_2x1_1_st.v"
//Bu satır, 2 girişli 1 çıkışlı bir çoklayıcı modülünün (mux_2x1_1_st) içeriğini bu kod dosyasına dahil eder.


module mux_4x1_1_st(out, a, b, c, d, select);
//Bu satır, mux_4x1_1_st isimli modülü tanımlar. Bu modül, 4 giriş (a, b, c, d), 2-bitlik bir seçim (select) ve 1 çıkış (out) alır.

    input a, b, c, d;
    input [1:0] select; //2-bitlik seçim bitleri
    output out;
    //Bu satırlar, modülün giriş ve çıkış portlarını tanımlar. a, b, c ve d girişleri, çoklanacak veriyi temsil eder. select, çoklanacak girişler arasında seçim yapmak için kullanılan 2-bitlik bir sinyaldir. out, seçilen girişin çıkışını temsil eder.


    wire out1, out2;
    //Bu satır, ara çıkış sinyallerini tanımlar. out1 ve out2, birinci seviye 2x1 çoklayıcıların çıkışlarını geçici olarak saklar.

    // first level 2x1 MUXes
    //Bu satır, ilk seviye 2x1 çoklayıcıyı tanımlar. mux1, a ve b girişlerinden birini seçer ve çıkışını out1'e iletir. Hangi girişin seçileceği, select'in en üstteki biti (select[1]) tarafından belirlenir.

    mux_2x1_1_st mux1( // mux1, a ve b girişlerini seçer
        .out(out1),
        .a(a),
        .b(b),
        .select(select[1])
    );

    //Bu satır, ikinci seviye 2x1 çoklayıcıyı tanımlar. mux2, c ve d girişlerinden birini seçer ve çıkışını out2'ye iletir. Hangi girişin seçileceği, select'in en üstteki biti (select[1]) tarafından belirlenir.
    mux_2x1_1_st mux2( // mux2, c ve d girişlerini seçer
        .out(out2),
        .a(c),
        .b(d),
        .select(select[1])
    );

    //Bu satır, ikinci seviye 2x1 çoklayıcıyı tanımlar. mux3, mux1 ve mux2 çıkışları arasından birini seçer ve son çıkışı (out) oluşturur. Hangi çıkışın seçileceği, select'in en alttaki biti (select[0]) tarafından belirlenir.
    // second level 2x1 MUX
    mux_2x1_1_st mux3( // mux3, mux1 ve mux2 çıkışlarını seçer
        .out(out),
        .a(out1),
        .b(out2),
        .select(select[0])
    );
endmodule
//Bu satır, modül tanımını sonlandırır.

//Bu kod, 4 girişli bir çoklayıcıyı, iki seviyeli 2x1 çoklayıcılar kullanarak gerçekler. İlk seviyede, her biri iki giriş seçen iki adet 2x1 çoklayıcı bulunur. İkinci seviyede ise, bir önceki seviyeden gelen çıkışlar, bir başka 2x1 çoklayıcı ile seçilir ve sonuç çıkış olarak belirlenir. Bu yapı, genişletilebilir ve daha fazla girişli çoklayıcılar oluşturmak için kullanılabilir.


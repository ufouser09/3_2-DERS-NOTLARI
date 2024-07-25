// Half adder module
module half_adder(i0,i1,sum,carry);
    input i0, i1; // 1-bitlik girişler
    output sum, carry; // 1-bitlik çıkışlar
    xor x1(sum, i0, i1); // XOR ile toplamı hesapla
    and a1(carry, i0, i1); // AND ile taşımayı hesapla
endmodule

// Full adder module
module full_adder(i0, i1, cin, sum, cout);
    input i0, i1, cin; // 1-bitlik girişler
    output sum, cout; // 1-bitlik çıkışlar

    //wire sum_half, carry_half, carry_half_2;: Bu satır, ara değerler için tel (wire) tanımlar. sum_half, ilk yarı ekleyicinin çıkışını temsil eder. carry_half ve carry_half_2, taşıma sinyallerini temsil eder.
    wire sum_half, carry_half, carry_half_2; // ara değerleri belirtmek için

    // Yarı ekleyici modüllerini kullanarak tam ekleyici gerçekleştirme
    //half_adder ha1(i0, i1, sum_half, carry_half);: Bu satır, ilk yarı ekleyiciyi çağırır ve i0 ile i1'yi toplar. Sonuç sum_half'a, taşıma çıkışı ise carry_half'a atanır.

    half_adder ha1(i0, i1, sum_half, carry_half);
    
    //half_adder ha2(sum_half, cin, sum, carry_half_2);: Bu satır, ikinci yarı ekleyiciyi çağırır ve sum_half ile cin'i toplar. Sonuç sum'a, taşıma çıkışı ise carry_half_2'ye atanır.
    half_adder ha2(sum_half, cin, sum, carry_half_2);

    // Taşıma çıkışını hesapla
    //or o1(cout, carry_half, carry_half_2);: Bu satır, taşıma çıkışını hesaplar. İki yarı ekleyicinin taşıma çıkışlarını (carry_half ve carry_half_2) OR kapısı ile birleştirir ve sonucu cout çıkışına atar.
    or o1(cout, carry_half, carry_half_2);
endmodule

// 4 Bit adder module
module adder_4bit(i0, i1, cin, sum, cout);
    input [3:0] i0, i1; // bu satır 4 bitlik giriş portlarını tanımlar.
                        //i0 ve i1, toplanacak iki 4-bitlik sayıyı temsil eder.

    input cin; // taşıma giriş sinyalini temsil eder.

    output [3:0] sum; // 4-bitlik toplam çıkışı
    output cout; // taşıma çıkışı,cout taşıma çıkış sinyalini temsil eder.
    
    //wire carry_1, carry_2, carry_3;: Bu satır, ara taşıma çıkışları için tel (wire) tanımlar. carry_1, ilk tam ekleyicinin çıkışından gelen taşıma sinyalini temsil eder. carry_2 ve carry_3, sırasıyla ikinci ve üçüncü tam ekleyicilerin çıkışlarından gelen taşıma sinyallerini temsil eder.
    wire carry_1, carry_2, carry_3;

    //full_adder fa0(i0[0], i1[0], cin, sum[0], carry_1);: Bu satır, ilk bitleri toplamak için bir tam ekleyici çağırır. İlk bitler, i0[0] ve i1[0]'dan gelir. Taşıma girişi olarak cin kullanılır. Toplam sonucu sum[0]'a, taşıma çıkışı ise carry_1'e atanır.
    //full_adder fa1(i0[1], i1[1], carry_1, sum[1], carry_2);: Bu satır, ikinci bitleri toplamak için bir tam ekleyici çağırır. İkinci bitler, i0[1] ve i1[1]'den ve bir önceki tam ekleyicinin taşıma çıkışından gelir. Toplam sonucu sum[1]'e, taşıma çıkışı ise carry_2'ye atanır.
    //full_adder fa2(i0[2], i1[2], carry_2, sum[2], carry_3);: Bu satır, üçüncü bitleri toplamak için bir tam ekleyici çağırır. Üçüncü bitler, i0[2] ve i1[2]'den ve bir önceki tam ekleyicinin taşıma çıkışından gelir. Toplam sonucu sum[2]'e, taşıma çıkışı ise carry_3'e atanır.
    //full_adder fa3(i0[3], i1[3], carry_3, sum[3], cout);: Bu satır, dördüncü bitleri toplamak için bir tam ekleyici çağırır. Dördüncü bitler, i0[3] ve i1[3]'den ve bir önceki tam ekleyicinin taşıma çıkışından gelir. Toplam sonucu sum[3]'e, taşıma çıkışı ise cout'a atanır.
    // Tam ekleyici modüllerini kullanarak 4-bitlik toplama gerçekleştirme
    full_adder fa0(i0[0], i1[0], cin, sum[0], carry_1);
    full_adder fa1(i0[1], i1[1], carry_1, sum[1], carry_2);
    full_adder fa2(i0[2], i1[2], carry_2, sum[2], carry_3);
    full_adder fa3(i0[3], i1[3], carry_3, sum[3], cout);
endmodule

// 32 Bit adder module
module adder_32bit(sum, cout, i0, i1, cin);
    input [31:0] i0, i1; // 32-bitlik girişler
    input cin; // taşıma girişi
    output [31:0] sum; // 32-bitlik toplam çıkışı
    output cout; // taşıma çıkışı
    wire carry_1, carry_2, carry_3, carry_4, carry_5, carry_6, carry_7;

    // 4-bitlik ekleyici modüllerini kullanarak 32-bitlik toplama gerçekleştirme
    adder_4bit a0(i0[3:0], i1[3:0], cin, sum[3:0], carry_1);
    adder_4bit a1(i0[7:4], i1[7:4], carry_1, sum[7:4], carry_2);
    adder_4bit a2(i0[11:8], i1[11:8], carry_2, sum[11:8], carry_3);
    adder_4bit a3(i0[15:12], i1[15:12], carry_3, sum[15:12], carry_4);
    adder_4bit a4(i0[19:16], i1[19:16], carry_4, sum[19:16], carry_5);
    adder_4bit a5(i0[23:20], i1[23:20], carry_5, sum[23:20], carry_6);
    adder_4bit a6(i0[27:24], i1[27:24], carry_6, sum[27:24], carry_7);
    adder_4bit a7(i0[31:28], i1[31:28], carry_7, sum[31:28], cout); 
endmodule

// MUX 2x1 1bit module
module mux_2x1_1bit(out, i0, i1, select);
    input i0, i1, select; // 1-bitlik girişler//input i0, i1, select;: Bu satır, 1-bitlik giriş portlarını tanımlar. i0 ve i1, MUX'a gelen iki farklı giriş sinyalini temsil eder. select, hangi girişin seçileceğini belirten seçim sinyalini temsil eder.
    output out; // 1-bitlik çıkış//output out;: Bu satır, 1-bitlik çıkış portunu tanımlar. out, MUX tarafından seçilen giriş sinyalini temsil eder.
    assign out = (select & i1) | (~select & i0); // Seçime göre çıkışı belirleme toplama veya çıkarma için//assign out = (select & i1) | (~select & i0);: Bu satır, çıkış sinyalini belirler. Eğer select 1 ise, i1 girişi seçilir; aksi halde, i0 girişi seçilir. Bu durum, bir çeşit elektronik anahtarlama olarak düşünülebilir: eğer anahtar açıksa (select = 1), çıkış i1 girişine bağlanır; aksi halde (select = 0), çıkış i0 girişine bağlanır.
endmodule
//Bu şekilde, mux_2x1_1bit modülü, iki farklı giriş sinyali arasında seçim yaparak bir çıkış sinyali üretir. Bu, veriyi yönlendirmek veya birden fazla kaynaktan gelen bilgi arasından seçim yapmak gibi durumlarda kullanışlı olabilir.




// MUX 2x1 4bit module
module mux_2x1_4bit(out, i0, i1, select);
    input [3:0] i0, i1; // 4-bitlik girişler
    input select; // 1-bitlik seçim sinyali
    output [3:0] out; // 4-bitlik çıkış

    // 2x1 1-bitlik MUX'ları kullanarak 4-bitlik MUX gerçekleştirme
    //mux_2x1_1bit mux0 (out[0], i0[0], i1[0], select);: Bu satır, 1-bitlik MUX modülünü çağırarak her bir bit için seçim yapar. Örneğin, mux0, 0'ıncı bit için çalışır ve i0[0] ve i1[0] girişlerinden birini select sinyaline göre seçer ve sonucu out[0] çıkışına iletir. Bu, diğer bitler için de aynı şekilde gerçekleşir.
    mux_2x1_1bit mux0 (out[0], i0[0], i1[0], select);
    mux_2x1_1bit mux1 (out[1], i0[1], i1[1], select);
    mux_2x1_1bit mux2 (out[2], i0[2], i1[2], select);
    mux_2x1_1bit mux3 (out[3], i0[3], i1[3], select);
endmodule
//Bu şekilde, mux_2x1_4bit modülü, her bir 4-bitlik giriş vektörü için ayrı ayrı MUX'lar kullanarak bir 4-bitlik çıkış vektörü üretir. Bu, birden fazla veri kaynağı arasından seçim yapmak veya birden fazla veriyi birleştirmek için kullanılabilir.


// MUX 2x1 32bit module
module mux_2x1_32bit(out, i0, i1, select);
    input [31:0] i0, i1; // 32-bitlik girişler//input [31:0] i0, i1;: Bu satır, 32-bitlik giriş portlarını tanımlar. i0 ve i1, MUX'a gelen iki farklı 32-bitlik giriş sinyalini temsil eder.
    input select; // 1-bitlik seçim sinyali//input select;: Bu satır, 1-bitlik bir seçim sinyalini tanımlar. Bu sinyal, hangi girişin MUX tarafından çıkış olarak seçileceğini belirler.
    output [31:0] out; // 32-bitlik çıkış//output [31:0] out;: Bu satır, 32-bitlik bir çıkış portunu tanımlar. out, MUX tarafından seçilen giriş sinyalini temsil eder.

    // 2x1 4-bitlik MUX'ları kullanarak 32-bitlik MUX gerçekleştirme
    //mux_2x1_4bit mux0 (out[3:0], i0[3:0], i1[3:0], select);: Bu satır, 4-bitlik MUX modülünü çağırarak her bir 4-bitlik grup için seçim yapar. Örneğin, mux0, 0'dan 3'e kadar olan bitler için çalışır ve i0[3:0] ve i1[3:0] girişlerinden birini select sinyaline göre seçer ve sonucu out[3:0] çıkışına iletir. Bu, diğer 4-bitlik gruplar için de aynı şekilde gerçekleşir.
    mux_2x1_4bit mux0 (out[3:0], i0[3:0], i1[3:0], select);
    mux_2x1_4bit mux1 (out[7:4], i0[7:4], i1[7:4], select);
    mux_2x1_4bit mux2 (out[11:8], i0[11:8], i1[11:8], select);
    mux_2x1_4bit mux3 (out[15:12], i0[15:12], i1[15:12], select);
    mux_2x1_4bit mux4 (out[19:16], i0[19:16], i1[19:16], select);
    mux_2x1_4bit mux5 (out[23:20], i0[23:20], i1[23:20], select);
    mux_2x1_4bit mux6 (out[27:24], i0[27:24], i1[27:24], select);
    mux_2x1_4bit mux7 (out[31:28], i0[31:28], i1[31:28], select);
endmodule
//Bu şekilde, mux_2x1_32bit modülü, her bir 4-bitlik grup için ayrı ayrı 4-bitlik MUX'lar kullanarak bir 32-bitlik çıkış vektörü üretir. Bu, birden fazla veri kaynağı arasından seçim yapmak veya birden fazla veriyi birleştirmek için kullanılabilir.

// MUX 5x3 32bit module
module mux_5x3_32bit(out, i0, i1, i2, i3, i4, select);
    input [31:0] i0, i1, i2, i3, i4; // 32-bitlik girişler
                                     //input [31:0] i0, i1, i2, i3, i4;: Bu satır, 32-bitlik beş ayrı giriş portunu tanımlar. i0, i1, i2, i3 ve i4, MUX'a gelen beş farklı 32-bitlik giriş sinyalini temsil eder.   

    input [2:0] select; // 3-bitlik seçim sinyali//input [2:0] select;: Bu satır, 3-bitlik bir seçim sinyalini tanımlar. Bu sinyal, hangi girişin MUX tarafından çıkış olarak seçileceğini belirler.
    output [31:0] out; // 32-bitlik çıkış//output [31:0] out;: Bu satır, 32-bitlik bir çıkış portunu tanımlar. out, MUX tarafından seçilen giriş sinyalini temsil eder.
    wire [31:0] w0, w1, w2, w3;//wire [31:0] w0, w1, w2, w3;: Bu satır, ara bağlantıları temsil eden dört tane 32-bitlik tel tanımlar.

    // 2x1 32-bitlik MUX'lar kullanarak 5 giriş arasında seçim yapma
    //mux_2x1_32bit mux0 (w0, i0, i1, select[0]);: Bu satır, 32-bitlik MUX modülünü çağırarak ilk iki giriş arasında seçim yapar. mux0, i0 ve i1 girişlerinden birini select[0] sinyaline göre seçer ve sonucu w0 teline iletir.
    mux_2x1_32bit mux0 (w0, i0, i1, select[0]);
    mux_2x1_32bit mux1 (w1, i2, i3, select[0]);
    mux_2x1_32bit mux2 (w2, w0, w1, select[1]);
    mux_2x1_32bit mux3 (out, w2, i4, select[2]);
endmodule
//Bu şekilde, mux_5x3_32bit modülü, beş giriş arasından seçim yapmak için üç seviyede 32-bitlik MUX'ları kullanır. Bu, birçok veri kaynağı arasından seçim yapmak için kullanılabilir.


// Set less than module
module slt(out, i0_msb, i1_msb, sum_msb, alucontrol);
    input i0_msb, i1_msb, sum_msb; // 1-bitlik girişler//input i0_msb, i1_msb, sum_msb;: Bu satır, i0_msb, i1_msb ve sum_msb isimli üç 1-bitlik giriş portunu tanımlar. Bunlar, karşılaştırma yapılacak olan 32-bitlik sayıların en anlamlı bitlerini temsil eder.
    input [2:0] alucontrol; // 3-bitlik kontrol sinyali//input [2:0] alucontrol;: Bu satır, alucontrol isimli üç bitlik kontrol sinyalini tanımlar. Bu sinyal, SLT işlemi için kontrol parametrelerini belirler.
    output [31:0] out; // 32-bitlik çıkış//output [31:0] out;: Bu satır, 32-bitlik bir çıkış portunu tanımlar. out, SLT işlemi sonucu oluşan taşma durumunu temsil eder.
    wire overflow;      //wire overflow;: Bu satır, taşma durumunu tutacak olan bir tel tanımlar.

    // Set Less Than (slt) işlemini gerçekleştirme
    //assign overflow = (~(i0_msb ^ i1_msb ^ alucontrol[0]) & (i0_msb ^ sum_msb) & ~alucontrol[1]) ^ sum_msb;: Bu satır, SLT işlemini gerçekleştirir. SLT işlemi, alucontrol sinyalinin kontrolüne bağlı olarak gerçekleşir. i0_msb, i1_msb ve sum_msb bitlerinin XOR ve AND mantıksal operatörleri kullanılarak hesaplanır ve sonucu overflow teline atanır.
    assign overflow = (~(i0_msb ^ i1_msb ^ alucontrol[0]) & (i0_msb ^ sum_msb) & ~alucontrol[1]) ^ sum_msb;
    
    // Taşma bitini 32-bitlik çıkışa ekleme
    //assign out = {31'd0, overflow};: Bu satır, out çıkışına taşma bitini ekler. Diğer 31 bit 0 değeriyle doldurulur.
    assign out = {31'd0, overflow};
endmodule
//Bu şekilde, slt modülü, iki 32-bitlik sayıyı karşılaştırarak Set Less Than işlemini gerçekleştirir ve sonucunu taşma bitiyle birlikte çıkış olarak sunar.



// ALU 32bit module
module alu_32bit(result, cout, a, b, alucontrol);
    input [31:0] a, b; // 32-bitlik girişler//input [31:0] a, b;: Bu satır, a ve b isimli iki 32-bitlik giriş portunu tanımlar. Bu portlar, ALU'nun işlem yapacağı sayıları temsil eder.
    input [2:0] alucontrol; // 3-bitlik kontrol sinyali//input [2:0] alucontrol;: Bu satır, alucontrol isimli üç bitlik kontrol sinyalini tanımlar. Bu sinyal, ALU'nun hangi işlemi gerçekleştireceğini belirler.
    output [31:0] result; // 32-bitlik çıkış//output [31:0] result;: Bu satır, result isimli 32-bitlik bir çıkış portunu tanımlar. Bu port, ALU işlemi sonucu oluşan değeri temsil eder.
    output cout; // taşıma çıkışı//output cout;: Bu satır, taşıma çıkışını temsil eden bir çıkış portunu tanımlar.
    wire [31:0] add_sub, and_, xor_, slt, w0;//wire [31:0] add_sub, and_, xor_, slt, w0;: Bu satır, ara değerleri tutacak olan telleri tanımlar.

    // MUX'lar ve diğer modüller kullanılarak ALU işlemlerini gerçekleştirme
    //mux_2x1_32bit mux0 (w0, b, ~b, alucontrol[0]);: Bu satır, 32-bitlik bir MUX kullanarak ALU kontrol sinyaline bağlı olarak negatif b değerini seçer ve w0 teline atar.
    mux_2x1_32bit mux0 (w0, b, ~b, alucontrol[0]); // Negatif b'yi almak için bir MUX
    
    //adder_32bit adder (add_sub, cout, a, w0, alucontrol[0]);: Bu satır, 32-bitlik bir toplama veya çıkarma işlemi gerçekleştirir. Toplama veya çıkarma işlemi, a ve w0 değerleri arasında yapılır. Taşıma çıkışı cout sinyaline atanır.
    adder_32bit adder (add_sub, cout, a, w0, alucontrol[0]); // Toplama veya çıkarma gerçekleştirme
    assign and_ = a & b; // Mantıksal AND işlemi
    assign xor_ = a ^ b; // Mantıksal XOR işlemi
    slt slt0 (slt, a[31], b[31], add_sub[31], alucontrol); // Küçüktür (slt) işlemi

    //mux_5x3_32bit mux1 (result, add_sub, add_sub, and_, xor_, slt, alucontrol);: Bu satır, 32-bitlik bir MUX kullanarak doğru işlem sonucunu seçer ve result çıkışına atar.
    // MUX kullanarak doğru işlem sonucunu seçme
    mux_5x3_32bit mux1 (result, add_sub, add_sub, and_, xor_, slt, alucontrol);
endmodule
//Bu şekilde, alu_32bit modülü, a ve b değerlerine ve kontrol sinyaline bağlı olarak farklı aritmetik ve mantıksal işlemleri gerçekleştirir ve sonucu result çıkışında sunar.


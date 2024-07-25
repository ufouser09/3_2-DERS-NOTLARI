`include "half_adder.v"

//Bu satır, yarı toplayıcı modülünün (half_adder.v) 
//içeriğini bu test benchesi dosyasına dahil eder. 
//Böylece, yarı toplayıcı modülünün tanımları bu dosyada 
//kullanılabilir hale gelir.

module half_adder_tb;
    reg a, b;
    //adında iki reg (register) değişkeni tanımlar. 
    //Bunlar, test için kullanılacak girişlerdir.

    wire sum, carry;
    //sum ve carry adında iki wire (tel) değişkeni tanımlar.
    //Bunlar, yarı toplayıcı modülünden gelen çıkışları temsil eder.

    half_adder add1(a, b, sum, carry);
    //half_adder modülünden bir örnek oluşturur. 
    //Bu örneğe add1 adını verir ve girişleri a ve b, 
    //çıkışları ise sum ve carry ile bağlar.

    initial begin 
    // Bu satırdan itibaren, başlangıç 
    //durumunu belirten kod bloğu başlar.
        

        //Bu iki satır, simülasyon sırasında değişken değerlerini bir VCD dosyasına kaydetmek
        //için kullanılır. Bu dosya, simülasyon sonuçlarını görselleştirmek için kullanılabilir.
        //a=0; b=0;, a=0; b=1;, a=1; b=0;, a=1; b=1;: 
        //Bu satırlar, a ve b girişlerinin farklı kombinasyonlarını test etmek için kullanılır. 
        //Her kombinasyondan sonra #1; ile belirtilen 1 zaman birimi beklenir. 
        //Bu şekilde, her kombinasyonun sonucunun doğru olup olmadığı kontrol edilir.
        
        $dumpfile("half_adder.vcd");
        $dumpvars(0, half_adder_tb);

        a=0; b=0;
        #1;
        a=0; b=1;
        #1;
        a=1; b=0;
        #1;
        a=1; b=1;
    end

endmodule


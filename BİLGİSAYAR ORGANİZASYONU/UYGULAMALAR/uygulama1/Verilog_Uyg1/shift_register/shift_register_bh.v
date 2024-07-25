module shift_register_bh(
    //input clk, reset, data_in;: Bu satır, giriş portlarını tanımlar. clk, saat sinyalini temsil eder. reset, sıfırlama sinyalini temsil eder. data_in, giriş veriyi temsil eder.
    input clk,
    input reset,
    input data_in,
    //output reg [3:0] data_out;: Bu satır, çıkış portunu tanımlar. data_out, kaydırılmış veriyi temsil eder.
    output reg [3:0] data_out
);
    //reg [3:0] register;: Bu satır, 4-bitlik bir register (kayıt) tanımlar. Bu, kaydırma kaydırıcının içinde saklanacak veriyi temsil eder.
    reg [3:0] register;

//Bu blok, herhangi bir pozitif kenar (positive edge) sinyali veya reset sinyali algılandığında çalışan bir bloktur.
    always @(posedge clk or posedge reset) begin
    //if (reset) register <= 4'b0000;: Eğer reset sinyali aktif ise, kaydırma kaydırıcının içindeki veri sıfırlanır.
        if (reset)
            register <= 4'b0000;
        else
        //else register <= {register[2:0], data_in};: Eğer reset sinyali aktif değilse, kaydırma işlemi gerçekleşir. register içindeki veri 3 bit sola kaydırılır ve data_in değeri en sağdaki bit olarak eklenir.
            // concat LSB 3 bits of reg to data_in value to shift left
            register <= {register[2:0], data_in};
    end
    //always @* data_out = register;: Bu blok, herhangi bir değişiklik olduğunda data_out'a register'ın değerini atar. Böylece, data_out, kaydırma işleminden sonra register içindeki veriyi temsil eder.
    // register'ın değişen değerini data_out'a assign et
    //Bu şekilde, bu kaydırma kaydırıcı modülü, her bir saat darbesinde gelen veriyi sola doğru kaydırarak 4-bitlik bir kaydırma işlemi gerçekleştirir.
    always @*
        data_out = register;
endmodule
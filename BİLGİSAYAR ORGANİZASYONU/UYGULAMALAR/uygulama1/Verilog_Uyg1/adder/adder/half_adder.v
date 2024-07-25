module half_adder(a,b,sum,carry);//4 giriş çıkış portu vardır
    input a, b;                 //2 girişi temsil eder
    output sum, carry;          //2 çıkışı temsil eder
    xor x1(sum, a, b);          //burda bir xor kapısı vardır.a ve b girişleri sum çıkışına bağlanır.
    and a1(carry, a, b);        //and kapısı a ve b girişleri carry çıkışına bağlanır.
endmodule

//Bu modül, bir yarı toplayıcıyı tanımlar. 
//Yarı toplayıcı, iki bitlik sayıları toplar ve 
//sonucu (sum) ve taşımayı (carry) üretir.




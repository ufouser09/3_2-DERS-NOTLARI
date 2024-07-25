/* Full adder module */
//Bu kod, bir tam toplayıcı modülünü (full adder) tanımlar. Tam toplayıcılar, iki bitlik sayıların yanı sıra bir taşıma (carry) girişi alır ve bu girişlerin toplamını hesaplar. İşte kodun Türkçe açıklaması:


`include "half_adder.v"//Bu satır, half_adder.v dosyasının içeriğini bu kod dosyasına dahil eder. Bu dosya, yarı toplayıcı modülünü içerir ve tam toplayıcı modülünde kullanılır.

module full_adder(a, b, cin, sum, cout);//Bu satır, full_adder adında bir modül oluşturur. Bu modül, a, b, cin, sum ve cout adlarında beş giriş/çıkış portuna sahiptir. a ve b girişleri toplanacak iki bitlik sayıları temsil eder. cin, taşıma girişini temsil eder. sum, toplam sonucunu, cout ise taşıma çıkışını temsil eder.
    
    input a, b, cin;//Bu satırlar, modülün giriş ve çıkışlarını tanımlar.
    output sum, cout;
    wire sum_half, carry_half, carry_half_2;//Bu satır, içsel bağlantılar için üç tane wire tanımlar. sum_half, ilk yarı toplayıcıdan (ha1) gelen toplam sonucunu, carry_half, ilk yarı toplayıcıdan gelen taşıma çıkışını, carry_half_2, ikinci yarı toplayıcıdan (ha2) gelen taşıma çıkışını temsil eder.

    half_adder ha1(a, b, sum_half, carry_half);//Bu satır, half_adder modülünden (half_adder.v) bir örnek oluşturur ve ha1 adını verir. Bu örneğe, a ve b girişlerini bağlar ve sum_half ve carry_half çıkışlarını alır. Bu, ilk yarı toplayıcıyı temsil eder.
    half_adder ha2(sum_half, cin, sum, carry_half_2);//Bu satırda da bir half_adder örneği oluşturulur ve ha2 adını alır. Bu sefer sum_half ve cin girişlerini bağlar ve sum ve carry_half_2 çıkışlarını alır. Bu, ikinci yarı toplayıcıyı temsil eder.

    or o1(cout, carry_half, carry_half_2);//Bu satır, bir or kapısı örneği oluşturur ve o1 adını alır. Bu kapı, carry_half ve carry_half_2 girişlerini alır ve bu girişlerin herhangi biri 1 olduğunda cout çıkışını 1 yapar. Bu, toplamın taşmayı temsil eden çıkışıdır.
endmodule
//Bu modül, iki yarı toplayıcı kullanarak tam toplama işlemini gerçekleştirir. İlk yarı toplayıcı, iki sayının birbirleriyle olan toplamını ve bir taşıma çıkışını hesaplar. İkinci yarı toplayıcı ise ilk yarı toplayıcının çıkışını ve taşıma girişini kullanarak son toplam sonucunu ve taşıma çıkışını hesaplar. Bu sayede, tam toplama işlemi gerçekleştirilir.
// DFlipFlop_st.v

//Bu kısım, NAND kapısının işlevselliğini tanımlar. NAND kapısı, girişlerin AND işlemi sonucunun tersidir.
module nand_gate(c,a,b);
    input a,b;
    output c;
    assign c= ~(a & b);
endmodule

//Bu kısım, NOT kapısının işlevselliğini tanımlar. NOT kapısı, girişin tersini çıkış olarak üretir.
module not_gate(f,e);
    input e;
    output f;
    assign f = ~e;
endmodule


module DFlipFlop_st(q,qbar,d,clk);
input d,clk; 
output q, qbar; 
not_gate not1(dbar,d); 
nand_gate nand1(x,clk,d); 
nand_gate nand2(y,clk,dbar); 
nand_gate nand3(q,qbar,x); 
nand_gate nand4(qbar,q,y); 
endmodule

//Bu kısım, D flip-flop'un işlevselliğini tanımlar. D flip-flop, bir giriş verisini (d) alır ve bir saat sinyali (clk) tarafından tetiklenir. q çıkışı, giriş verisinin saat sinyalinin yükselen kenarında (pozitif kenarında) alınan değerini yansıtır. qbar çıkışı ise q'nun tersidir.
not_gate not1(dbar, d);: Giriş verisinin tersini üretmek için bir NOT kapısı oluşturulur.
nand_gate nand1(x, clk, d);: Giriş verisi (d) ve saat sinyali (clk) kullanılarak bir NAND kapısı oluşturulur. Bu, bir tetikleme mekanizması sağlar.
nand_gate nand2(y, clk, dbar);: Giriş verisinin tersi (dbar) ve saat sinyali (clk) kullanılarak bir NAND kapısı oluşturulur. Bu, tetiklemenin tersini sağlar.
nand_gate nand3(q, qbar, x);: Giriş verisine bağlı olarak q ve qbar çıkışlarını sağlamak için bir NAND kapısı oluşturulur.
nand_gate nand4(qbar, q, y);: Giriş verisine bağlı olarak qbar ve q çıkışlarını sağlamak için bir NAND kapısı oluşturulur.
Bu şekilde, D flip-flop'un iç yapısı NAND ve NOT kapıları kullanılarak tasarlanmıştır. Bu yapı, verinin saat sinyaliyle senkronize edilerek saklanmasını sağlar.
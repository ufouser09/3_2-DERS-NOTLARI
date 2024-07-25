module mux_2x1_1_st(out, a, b, select);//Bu satır, mux_2x1_1_st adında bir modül tanımlar. Bu modül, out, a, b ve select adlarında dört girişe sahiptir. out, çoklanmış çıkışı temsil ederken, a ve b girişleri çoklanacak sinyalleri, select ise seçim yapmayı kontrol eden sinyali temsil eder.
    //Bu satırlar, modülün giriş ve çıkışlarını tanımlar. a, b ve select girişleri, çoklanacak sinyalleri ve seçim sinyalini temsil ederken, out çıkışı çoklanmış çıkışı temsil eder. and_1, and_2 ve select_not telleri ara bağlantıları temsil eder.
    input a, b, select;
    wire and_1, and_2, select_not;
    output out;
    
    not (select_not, select);//Bu satır, select_not adında bir NOT kapısını tanımlar. Bu kapı, select girişinin tersini (select_not) alır.
    
    and (and_1, a, select);//Bu satırlar, and_1 ve and_2 adında iki AND kapısını tanımlar. and_1, giriş sinyalleri a ve select arasındaki AND işlemi sonucunu üretir. and_2, giriş sinyalleri b ve select_not arasındaki AND işlemi sonucunu üretir.
    and (and_2, b, select_not);
    
    //Bu satır, out çıkışını tanımlar. Bu çıkış, and_1 ve and_2 sinyalleri arasındaki OR işlemi sonucunu üretir. Yani, select girişi aktif olduğunda (1 olduğunda), a girişi çıkışa bağlanır; aksi halde (0 olduğunda), b girişi çıkışa bağlanır.
    or (out, and_1, and_2);
endmodule

//Bu şekilde, çoklayıcı modülü, seçim sinyali tarafından kontrol edilerek iki farklı giriş arasında seçim yapar ve seçilen girişi çıkışa aktarır.
/*module sort_tb;
    reg clk;
    reg reset;
    wire [31:0] WriteData, DataAdr;
    wire MemWrite;
    integer i;
    //integer ARR = {3, 7, 2, 6, 5, 4, 1, 1000, 999, 25, 90, 100, 30, 20, 10, 200, 3300, 250, 12, 75};
    //integer COUNT = {17, 13, 18, 14, 15, 16, 19, 1, 2, 9, 6, 5, 8, 10, 12, 4, 0, 3, 11, 7};
    // Instantiate the top module
    top uut (
        .clk(clk), 
        .reset(reset), 
        .WriteData(WriteData), 
        .DataAdr(DataAdr), 
        .MemWrite(MemWrite)
    );
    // ARR and COUNT initialization values
    reg [31:0] ARR [0:19];
    reg [31:0] COUNT [0:19];

    // Clock generation
    always begin
        clk = 1; 
        #5; 
        clk = 0; 
        #5;
    end

    // Apply reset
    initial begin
        reset = 1;
        #22; 
        reset = 0;
    end

    initial begin
        // Initialize ARR array
        ARR[0] = 32'd3;
        ARR[1] = 32'd7;
        ARR[2] = 32'd2;
        ARR[3] = 32'd6;
        ARR[4] = 32'd5;
        ARR[5] = 32'd4;
        ARR[6] = 32'd1;
        ARR[7] = 32'd1000;
        ARR[8] = 32'd999;
        ARR[9] = 32'd25;
        ARR[10] = 32'd90;
        ARR[11] = 32'd100;
        ARR[12] = 32'd30;
        ARR[13] = 32'd20;
        ARR[14] = 32'd10;
        ARR[15] = 32'd200;
        ARR[16] = 32'd3300;
        ARR[17] = 32'd250;
        ARR[18] = 32'd12;
        ARR[19] = 32'd75;

        // Initialize COUNT array
        COUNT[0] = 32'd17;
        COUNT[1] = 32'd13;
        COUNT[2] = 32'd18;
        COUNT[3] = 32'd14;
        COUNT[4] = 32'd15;
        COUNT[5] = 32'd16;
        COUNT[6] = 32'd19;
        COUNT[7] = 32'd1;
        COUNT[8] = 32'd2;
        COUNT[9] = 32'd9;
        COUNT[10] = 32'd6;
        COUNT[11] = 32'd5;
        COUNT[12] = 32'd8;
        COUNT[13] = 32'd10;
        COUNT[14] = 32'd12;
        COUNT[15] = 32'd4;
        COUNT[16] = 32'd0;
        COUNT[17] = 32'd3;
        COUNT[18] = 32'd11;
        COUNT[19] = 32'd7;
    end
    // Initialize ARR and COUNT arrays in the data memory
    initial begin
         $dumpfile("sort.vcd"); 
        $dumpvars(0, sort_tb);
        // Wait for reset to be de-asserted
        #25;

        // Write ARR array to memory
        for (i = 0; i < 20; i = i + 1) begin
            force uut.dmem.RAM[i] = ARR[i];
        end

        // Write COUNT array to memory
        for (i = 0; i < 20; i = i + 1) begin
            force uut.dmem.RAM[32 + i] = COUNT[i];
        end

        // Zero out RESULT array in memory
        for (i = 0; i < 20; i = i + 1) begin
            force uut.dmem.RAM[64 + i] = 32'd0;
        end
        force uut.rf[0]=32'b0;
    end
    i=0;
    // Check results and display progress
    always @(negedge clk) begin
        $display("%d",uut.dmem.RAM[64+i])
        i+=1;
    end
        // andi x2, x2, 0 // x2 = 0
        // addi x7,x2,0 // arr adress
        // addi x8,x2,32// count adress
        // addi x9,x2,64 // result address

        // addi x6,x2,1 //x6=1
        // LOOP:
        // lw x3, x8(x2) // x3 = COUNT[x2]
        // lw x4, x7(x2) // x4 = ARR[x2]
        // sw x9(x3), x4 // RESULT[x3] = ARR[x2]

        // addi x2, x2, 1 // t2++

        // slt x1, x2, 20 // x1 = 1 if x2 < 80 (20*4 = 80, dizide 20 eleman olduğu için)
        // beq x1,x6 LOOP // Loop if x1 == 1
*/
module sort_tb;
    reg clk;
    reg reset;
    wire [31:0] WriteData, DataAdr;
    wire MemWrite;
    integer i;

    // Instantiate the top module
    top uut (
        .clk(clk), 
        .reset(reset), 
        .WriteData(WriteData), 
        .DataAdr(DataAdr), 
        .MemWrite(MemWrite)
    );

    // Clock generation
    always begin
        clk = 1; 
        #5; 
        clk = 0; 
        #5;
    end

    // Apply reset
    initial begin
        reset = 1;
        #22; 
        reset = 0;
    end

    // Initialize ARR and COUNT arrays in the data memory
    initial begin
        $dumpfile("sort.vcd"); 
        $dumpvars(0, sort_tb);

        // Wait for reset to be de-asserted
        #25;

        // Write ARR array to memory
        uut.dmem.RAM[0] = 32'd3;
        uut.dmem.RAM[1] = 32'd7;
        uut.dmem.RAM[2] = 32'd2;
        uut.dmem.RAM[3] = 32'd6;
        uut.dmem.RAM[4] = 32'd5;
        uut.dmem.RAM[5] = 32'd4;
        uut.dmem.RAM[6] = 32'd1;
        uut.dmem.RAM[7] = 32'd1000;
        uut.dmem.RAM[8] = 32'd999;
        uut.dmem.RAM[9] = 32'd25;
        uut.dmem.RAM[10] = 32'd90;
        uut.dmem.RAM[11] = 32'd100;
        uut.dmem.RAM[12] = 32'd30;
        uut.dmem.RAM[13] = 32'd20;
        uut.dmem.RAM[14] = 32'd10;
        uut.dmem.RAM[15] = 32'd200;
        uut.dmem.RAM[16] = 32'd3300;
        uut.dmem.RAM[17] = 32'd250;
        uut.dmem.RAM[18] = 32'd12;
        uut.dmem.RAM[19] = 32'd75;

        // Write COUNT array to memory
        uut.dmem.RAM[32] = 32'd17;
        uut.dmem.RAM[33] = 32'd13;
        uut.dmem.RAM[34] = 32'd18;
        uut.dmem.RAM[35] = 32'd14;
        uut.dmem.RAM[36] = 32'd15;
        uut.dmem.RAM[37] = 32'd16;
        uut.dmem.RAM[38] = 32'd19;
        uut.dmem.RAM[39] = 32'd1;
        uut.dmem.RAM[40] = 32'd2;
        uut.dmem.RAM[41] = 32'd9;
        uut.dmem.RAM[42] = 32'd6;
        uut.dmem.RAM[43] = 32'd5;
        uut.dmem.RAM[44] = 32'd8;
        uut.dmem.RAM[45] = 32'd10;
        uut.dmem.RAM[46] = 32'd12;
        uut.dmem.RAM[47] = 32'd4;
        uut.dmem.RAM[48] = 32'd0;
        uut.dmem.RAM[49] = 32'd3;
        uut.dmem.RAM[50] = 32'd11;
        uut.dmem.RAM[51] = 32'd7;

        // Zero out RESULT array in memory
        for (i = 0; i < 20; i = i + 1) begin
            uut.dmem.RAM[64 + i] = 32'd0;
        end

        // Ensure x0 in the regfile is always zero
       // force uut.regfile.rf[0] = 32'd0;
    end

    // Check results and display progress
    initial begin
        #5000; // Wait for some time to allow the operations to complete
        for (i = 0; i < 20; i = i + 1) begin
            $display("At time %t: RESULT[%0d] = %0d", $time, i, uut.dmem.RAM[64+i]);
        end
        $finish; // End the simulation
    end
endmodule

module mcrom_tb;
    reg [ 5 : 0] offset;
    reg clk;
    wire [`MCROM_WIDTH - 1 : 0] mc_word;
    microcode_rom uut (
        .offset(offset), 
        .mc_word(mc_word) 
    );
    initial begin
        offset = 0;
        clk = 0;
        #1000    $finish;
    end
    always
        #50        clk = ~clk;
    always @(posedge clk)
        offset = offset + 1;
endmodule
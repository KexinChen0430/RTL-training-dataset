module clock_generator(
    output reg clk_o,    
    output reg rst_o     
);
initial begin
    clk_o = 1'b0; 
    rst_o = 1'b1; 
    repeat(4) #5 clk_o = ~clk_o; 
    rst_o = 1'b0; 
    forever #5 clk_o = ~clk_o; 
end
endmodule
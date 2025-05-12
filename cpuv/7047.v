module mips_pipeline the_Mips(clk, reset); 
always #50 clk = ~clk; 
initial begin
clk = 1'b0; 
reset = 1'b1; 
#100 reset = 1'b0; 
end
endmodule 
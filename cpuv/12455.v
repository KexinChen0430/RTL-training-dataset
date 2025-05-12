module's undeclared outputs) 
reg clk_50m; 
reg locked; 
assign locked = resetn; 
assign clk_50m = clk_in; 
endmodule 
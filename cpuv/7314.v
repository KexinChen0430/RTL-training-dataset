module jizlots_tb; 
reg clk; 
reg[2:0] type; 
reg[1:0] rot; 
wire[0:15] block_out; 
JIZLOTS_sel write(type, rot, block_out); 
initial begin 
    clk <= 0; 
    type <= 0; 
    rot <= 0; 
end
always begin 
    #5 clk = !clk; 
end
endmodule 
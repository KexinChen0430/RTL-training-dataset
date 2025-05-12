module xlconcat (In0, In1, In2, In3, In4, In5, In6, In7, In8, In9, In10, In11, In12, In13, In14, In15,dout); 
parameter IN0_WIDTH = 1; 
input 	[IN0_WIDTH -1:0] In0; 
parameter IN1_WIDTH = 1; 
input 	[IN1_WIDTH -1:0] In1; 
parameter dout_width = 2; 
output [dout_width-1:0] dout; 
parameter NUM_PORTS =2; 
generate if (NUM_PORTS == 1) 
begin : C_NUM_1
    assign dout = In0; 
end
endgenerate
endmodule 
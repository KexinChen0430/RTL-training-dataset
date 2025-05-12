module $__SHREG_DFF_P_(input C, D, output Q); 
parameter DEPTH = 2; 
parameter [DEPTH-1:0] INIT = {DEPTH{1'b0}}; 
reg [DEPTH-1:0] r = INIT; 
always @(posedge C) 
    r <= { r[DEPTH-2:0], D }; 
assign Q = r[DEPTH-1]; 
endmodule 
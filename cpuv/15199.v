module ram_64x32
(
    output reg [31:0] q,      
    input [31:0] d,           
    input [5:0] waddr,        
    input [5:0] raddr,        
    input we,                 
    input c                   
);
reg [31:0] mem [63:0];
always @ (posedge c) begin
    if (we)                   
        mem[waddr] <= d;      
    q <= mem[raddr];          
end
`ifdef SIM
wire [31:0] a00 = mem[0];    
wire [31:0] a01 = mem[1];    
wire [31:0] a2e = mem[46];   
wire [31:0] a2f = mem[47];   
`endif
endmodule
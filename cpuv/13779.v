module toyblockram (
    input         clk,        
    input [31:0]  addr_a,     
    output [31:0] data_a,     
    input [31:0]  datain_a,   
    input         wr_a,       
    input [31:0]  addr_b,     
    output [31:0] data_b      
);
parameter RAM_DEPTH = `RAM_DEPTH; 
reg [31:0] mem [0:RAM_DEPTH-1]; 
assign data_a = wr_a ? datain_a : mem[addr_a]; 
assign data_b = mem[addr_b]; 
always @(posedge clk)
begin
    if (wr_a) begin
        mem[addr_a] = datain_a; 
        `ifdef DEBUG
        $display("STACK: [%x] <- %x", addr_a, datain_a); 
        `endif
    end
end
endmodule
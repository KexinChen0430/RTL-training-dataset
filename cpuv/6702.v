module memory (clock, wr, A, data);
input clock, wr, rd; 
input [31:0] A;
inout [7:0] data;
reg [31:0] mem [0:255];
always @(posedge clock)
    if (wr)
        mem[addr] = data; 
assign data = rd ? mem[addr] : 8'bZ; 
endmodule
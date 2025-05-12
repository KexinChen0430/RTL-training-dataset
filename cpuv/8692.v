module bram(input wire a_clk, 
    input wire a_wr, 
    input wire[16:0] a_addr, 
    input wire[11:0] a_din, 
    input wire b_clk, 
    input wire[16:0] b_addr, 
    output reg[11:0] b_dout); 
reg[11:0] mem[76799:0]; 
always @(posedge a_clk) begin 
    if (a_wr) begin 
        mem[a_addr] <= a_din; 
    end
end
always @(posedge b_clk) begin 
    b_dout <= mem[b_addr]; 
end
endmodule
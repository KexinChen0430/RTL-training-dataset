module nfa_accept_sample_multi_next_buckets_ram (addr0, ce0, d0, we0, q0, clk);
parameter DWIDTH = 64;   
parameter AWIDTH = 4;    
parameter MEM_SIZE = 16; 
input[AWIDTH-1:0] addr0; 
input ce0;               
input[DWIDTH-1:0] d0;    
input we0;               
output reg[DWIDTH-1:0] q0; 
input clk;               
(* ram_style = "block" *) reg [DWIDTH-1:0] ram[MEM_SIZE-1:0]; 
always @(posedge clk)
begin
    if (ce0) 
    begin
        if (we0) 
        begin
            ram[addr0] <= d0; 
            q0 <= d0;         
        end
        else 
            q0 <= ram[addr0]; 
    end
end
endmodule 
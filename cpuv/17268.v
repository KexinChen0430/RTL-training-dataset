module my_video_filter_line_buffers_val_1_ram (addr0, ce0, d0, we0, q0, addr1, ce1, d1, we1, q1,  clk);
parameter DWIDTH = 8; 
parameter AWIDTH = 13; 
parameter MEM_SIZE = 5760; 
input[AWIDTH-1:0] addr0; 
input ce0; 
input[DWIDTH-1:0] d0; 
input we0; 
output reg[DWIDTH-1:0] q0; 
input[AWIDTH-1:0] addr1; 
input ce1; 
input[DWIDTH-1:0] d1; 
input we1; 
output reg[DWIDTH-1:0] q1; 
input clk; 
(* ram_style = "block" *)reg [DWIDTH-1:0] ram[MEM_SIZE-1:0];
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
always @(posedge clk)
begin
    if (ce1) 
    begin
        if (we1) 
        begin
            ram[addr1] <= d1; 
            q1 <= d1; 
        end
        else
            q1 <= ram[addr1]; 
    end
end
endmodule
module image_filter_Filter2D_k_buf_0_val_0_ram (addr0, ce0, q0, addr1, ce1, d1, we1,  clk);
parameter DWIDTH = 8;
parameter AWIDTH = 11;
parameter MEM_SIZE = 1920;
input[AWIDTH-1:0] addr0;
input ce0;
output reg[DWIDTH-1:0] q0;
input[AWIDTH-1:0] addr1;
input ce1;
input[DWIDTH-1:0] d1;
input we1;
input clk;
(* ram_style = "block" *)reg [DWIDTH-1:0] ram[MEM_SIZE-1:0];
always @(posedge clk)
begin
    if (ce0)
    begin
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
        end
    end
end
endmodule
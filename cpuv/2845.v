module sram (
              inout  [15:0] SRAM_DQ,
              input  [17:0] SRAM_ADDR,
              input         SRAM_UB_N,
              input         SRAM_LB_N,
              input         SRAM_WE_N,
              input         SRAM_CE_N,
              input         SRAM_OE_N
             );
reg     [7:0] mem[`MEMSIZEBYTES-1:0];
wire [`MEMBYTEADDRBITS-1:0] byte_addr0 = {SRAM_ADDR, 1'b0};
wire [`MEMBYTEADDRBITS-1:0] byte_addr1 = {SRAM_ADDR, 1'b1};
wire   sram_read = ~SRAM_CE_N & ~SRAM_OE_N;
assign SRAM_DQ   = {(~sram_read | SRAM_UB_N) ? 8'hzz : mem[byte_addr1],
                    (~sram_read | SRAM_LB_N) ? 8'hzz : mem[byte_addr0]};
always @(*)
begin
  if (~SRAM_CE_N & ~SRAM_WE_N)
  begin
    if (~SRAM_LB_N)
      mem[byte_addr0]   = SRAM_DQ [7:0];
    if (~SRAM_UB_N)
      mem[byte_addr1]   = SRAM_DQ [15:8];
  end
end
endmodule
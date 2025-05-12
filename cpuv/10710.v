module or1200_spram 
  (
`ifdef OR1200_BIST
   mbist_si_i, 
   mbist_so_o, 
   mbist_ctrl_i, 
`endif
   clk, 
   ce, 
   we, 
   addr, 
   di, 
   doq 
   );
   parameter aw = 10; 
   parameter dw = 32; 
`ifdef OR1200_BIST
   input mbist_si_i; 
   input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i; 
   output mbist_so_o; 
`endif
   input clk; 
   input ce; 
   input we; 
   input [aw-1:0] addr; 
   input [dw-1:0] di; 
   output [dw-1:0] doq; 
`ifdef OR1200_GENERIC
   reg [dw-1:0] mem [(1<<aw)-1:0] ;
`else
   reg [dw-1:0] mem [(1<<aw)-1:0]; 
`endif
   reg [aw-1:0] addr_reg; 
integer k; 
   assign doq = mem[addr_reg]; 
   initial begin
       for(k = 0; k < (1 << aw); k = k + 1)
       begin
         mem[k] = 0; 
       end
   end
   always @(posedge clk)
     if (ce)
       addr_reg <= addr;
   always @(posedge clk)
     if (we && ce)
       mem[addr] <= di;
endmodule 
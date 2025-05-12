module or1200_spram_32_bw
  (
`ifdef OR1200_BIST
   mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif
   clk, ce, we, addr, di, doq
   );
   parameter aw = 10;
   parameter dw = 32;
`ifdef OR1200_BIST
   input mbist_si_i;
   input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
   output 				  mbist_so_o;
`endif
   input 				  clk;	
   input 				  ce;	
   input [3:0]				  we;	
   input [aw-1:0] 			  addr;	
   input [dw-1:0] 			  di;	
   output [dw-1:0] 			  doq;	
`ifdef OR1200_GENERIC
   reg [7:0] 				  mem0 [(1<<aw)-1:0] ;
   reg [7:0] 				  mem1 [(1<<aw)-1:0] ;
   reg [7:0] 				  mem2 [(1<<aw)-1:0] ;
   reg [7:0] 				  mem3 [(1<<aw)-1:0] ;
`else
   reg [7:0] 				  mem0 [(1<<aw)-1:0];
   reg [7:0] 				  mem1 [(1<<aw)-1:0];
   reg [7:0] 				  mem2 [(1<<aw)-1:0];
   reg [7:0] 				  mem3 [(1<<aw)-1:0];
`endif
   reg [aw-1:0] 			  addr_reg;		
   assign doq = {mem0[addr_reg], mem1[addr_reg], mem2[addr_reg], mem3[addr_reg]};
   always @(posedge clk)
     if (ce)
       addr_reg <=  addr;
   always @(posedge clk)
     if (ce) begin
       if (we[3])
         mem0[addr] <=  di[31:24];
       if (we[2])
         mem1[addr] <=  di[23:16];
       if (we[1])
         mem2[addr] <=  di[15:08];
       if (we[0])
         mem3[addr] <=  di[07:00];
     end
endmodule
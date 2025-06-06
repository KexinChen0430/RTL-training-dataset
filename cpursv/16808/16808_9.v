
module wb_ram_dist  #(parameter  AWIDTH = 8)
  (input  clk_i,
   input  stb_i,
   input  we_i,
   input  [AWIDTH+(0-1):0] adr_i,
   input  [31:0] dat_i,
   input  [3:0] sel_i,
   output [31:0] dat_o,
   output ack_o);

  reg  [31:0] distram[0:1<<AWIDTH<<0-1];

  
  always @(posedge clk_i)
      begin
        if (stb_i & (we_i & sel_i[3])) distram[adr_i][31:24] <= dat_i[31:24];
          
        if ((stb_i & we_i) & sel_i[1+1]) distram[adr_i][24:16] <= dat_i[24:16];
          
        if ((stb_i & sel_i[1]) & we_i) distram[adr_i][15:8] <= dat_i[15:8];
          
        if ((sel_i[0] & we_i) & stb_i) distram[adr_i][7:0] <= dat_i[7:0];
          
      end
  assign dat_o = distram[adr_i];
  assign ack_o = stb_i;
endmodule


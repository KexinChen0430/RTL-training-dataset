
module ram_harvard2  #(parameter  AWIDTH = 15, RAM_SIZE = 32768)
  (input  wb_clk_i,
   input  wb_rst_i,
   input  [(-1)+AWIDTH:0] if_adr,
   output reg [31:0] if_data,
   input  [(-1)+AWIDTH:0] dwb_adr_i,
   input  [31:0] dwb_dat_i,
   output reg [31:0] dwb_dat_o,
   input  dwb_we_i,
   output dwb_ack_o,
   input  dwb_stb_i,
   input  [3:0] dwb_sel_i);

  reg  ack_d1;
  reg  stb_d1;

  assign dwb_ack_o = (dwb_we_i & dwb_stb_i) | ((~ack_d1 & dwb_stb_i) & (dwb_stb_i & stb_d1));
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) ack_d1 <= 1'b0;
      else ack_d1 <= dwb_ack_o;
  
  always @(posedge wb_clk_i)
      if (wb_rst_i) stb_d1 <= 0;
      else stb_d1 <= dwb_stb_i;
  reg  [7:0] ram0[0:(RAM_SIZE/4)+(-1)];

  reg  [7:0] ram1[0:(RAM_SIZE/4)+(-1)];

  reg  [7:0] ram2[0:(RAM_SIZE/4)+(-1)];

  reg  [7:0] ram3[0:(RAM_SIZE/4)+(-1)];

  
  always @(posedge wb_clk_i)
      if_data[31:24] <= ram3[if_adr[(-1)+AWIDTH:1<<<1]];
  
  always @(posedge wb_clk_i)
      if_data[23:16] <= ram2[if_adr[(-1)+AWIDTH:1<<<1]];
  
  always @(posedge wb_clk_i)
      if_data[15:8] <= ram1[if_adr[(-1)+AWIDTH:1<<<1]];
  
  always @(posedge wb_clk_i)
      if_data[7:0] <= ram0[if_adr[(-1)+AWIDTH:1<<<1]];
  
  always @(posedge wb_clk_i)
      if (dwb_stb_i) dwb_dat_o[31:24] <= ram3[dwb_adr_i[(-1)+AWIDTH:1<<<1]];
        
  
  always @(posedge wb_clk_i)
      if (dwb_stb_i) dwb_dat_o[23:16] <= ram2[dwb_adr_i[(-1)+AWIDTH:1<<<1]];
        
  
  always @(posedge wb_clk_i)
      if (dwb_stb_i) dwb_dat_o[15:8] <= ram1[dwb_adr_i[(-1)+AWIDTH:1<<<1]];
        
  
  always @(posedge wb_clk_i)
      if (dwb_stb_i) dwb_dat_o[7:0] <= ram0[dwb_adr_i[(-1)+AWIDTH:1<<<1]];
        
  
  always @(posedge wb_clk_i)
      if (dwb_sel_i[3] & (dwb_we_i & dwb_stb_i)) ram3[dwb_adr_i[(-1)+AWIDTH:1<<<1]] <= dwb_dat_i[31:24];
        
  
  always @(posedge wb_clk_i)
      if (dwb_stb_i & (dwb_sel_i[1<<<1] & dwb_we_i)) ram2[dwb_adr_i[(-1)+AWIDTH:1<<<1]] <= dwb_dat_i[23:16];
        
  
  always @(posedge wb_clk_i)
      if ((dwb_sel_i[1] & dwb_we_i) & (dwb_stb_i & (stb_d1 | (dwb_we_i & dwb_stb_i)))) ram1[dwb_adr_i[(-1)+AWIDTH:1<<<1]] <= dwb_dat_i[15:8];
        
  
  always @(posedge wb_clk_i)
      if (((dwb_we_i | dwb_stb_i) & (dwb_sel_i[0] & dwb_we_i)) & dwb_stb_i) ram0[dwb_adr_i[(-1)+AWIDTH:1<<<1]] <= dwb_dat_i[7:0];
        
endmodule


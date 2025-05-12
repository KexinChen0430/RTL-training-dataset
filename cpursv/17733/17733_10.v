
module sdspi(output reg sclk,
             input  miso,
             output reg mosi,
             output reg ss,
             input  wb_clk_i,
             input  wb_rst_i,
             input  [8:0] wb_dat_i,
             output reg [7:0] wb_dat_o,
             input  wb_we_i,
             input  [1:0] wb_sel_i,
             input  wb_stb_i,
             input  wb_cyc_i,
             output reg wb_ack_o);

  wire op;
  wire start;
  wire send;
  reg  [7:0] tr;
  reg  st;
  reg  [7:0] sft;
  reg  [1:0] clk_div;

  assign op = wb_cyc_i & wb_stb_i;
  assign start = op & !st;
  assign send = wb_sel_i[0] & (wb_we_i & start);
  
  always @(posedge wb_clk_i)
      mosi <= wb_rst_i ? 1'b1 : 
             (clk_div == 2'b10) ? (send ? wb_dat_i[7] : tr[7]) : mosi;
  
  always @(posedge wb_clk_i)
      tr <= wb_rst_i ? 8'hff : 
           (clk_div == 2'b10) ? {send ? wb_dat_i[6:0] : tr[6:0],1'b1} : tr;
  
  always @(posedge wb_clk_i)
      wb_ack_o <= wb_rst_i ? 1'b0 : 
                 wb_ack_o ? 1'b0 : ((clk_div == 2'b00) && sft[0]);
  
  always @(posedge wb_clk_i)
      sft <= wb_rst_i ? 8'h0 : 
            (clk_div == 2'b10) ? {start,sft[7:1]} : sft;
  
  always @(posedge wb_clk_i)
      st <= wb_rst_i ? 1'b0 : 
           st ? !sft[0] : (op && (clk_div == 2'b10));
  
  always @(posedge wb_clk_i)
      wb_dat_o <= wb_rst_i ? 8'h0 : 
                 (op && (clk_div == 2'b0)) ? {wb_dat_o[6:0],miso} : wb_dat_o;
  
  always @(posedge wb_clk_i)
      sclk <= wb_rst_i ? 1'b1 : 
             clk_div[0] ? sclk : !(clk_div[1] & op);
  
  always @(negedge wb_clk_i)
      ss <= wb_rst_i ? 1'b1 : 
           ((op & wb_sel_i[1]) & wb_we_i) ? wb_dat_i[8] : ss;
  
  always @(posedge wb_clk_i)  clk_div <= (-2'd1)+clk_div;
endmodule


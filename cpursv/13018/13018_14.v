
module wb_dma_wb_mast(clk,rst,wb_data_i,wb_data_o,wb_addr_o,wb_sel_o,wb_we_o,
                      wb_cyc_o,wb_stb_o,wb_ack_i,wb_err_i,wb_rty_i,mast_go,mast_we,
                      mast_adr,mast_sel,mast_din,mast_dout,mast_err,mast_drdy,
                      mast_wait,pt_sel,mast_pt_in,mast_pt_out);

  input  clk,rst;
  input  [31:0] wb_data_i;
  output [31:0] wb_data_o;
  output [31:0] wb_addr_o;
  output [3:0] wb_sel_o;
  output wb_we_o;
  output wb_cyc_o;
  output wb_stb_o;
  input  wb_ack_i;
  input  wb_err_i;
  input  wb_rty_i;
  input  mast_go;
  input  mast_we;
  input  [31:0] mast_adr;
  input  [3:0] mast_sel;
  input  [31:0] mast_din;
  output [31:0] mast_dout;
  output mast_err;
  output mast_drdy;
  input  mast_wait;
  input  pt_sel;
  input  [70:0] mast_pt_in;
  output [34:0] mast_pt_out;
  reg  mast_cyc,mast_stb;
  reg  mast_we_r;
  reg  [3:0] mast_be;
  reg  [31:0] mast_dout;
  wire [31:0] mast_din_sel;

  assign {wb_data_o,wb_addr_o,wb_sel_o,wb_we_o,wb_cyc_o,wb_stb_o} = pt_sel ? mast_pt_in : {mast_din_sel,mast_adr,mast_be,mast_we_r,mast_cyc,mast_stb};
  assign mast_din_sel = ((mast_sel == 'b1000) || 
                        ((mast_sel == 'b0010) || (mast_sel == 'b0100) || 
(mast_sel == 'b0001))) ? {mast_din[7:0],mast_din[7:0],mast_din[7:0],mast_din[7:0]} : 
                        ((mast_sel == 'b0011) || (mast_sel == 'b1100)) ? {mast_din[15:0],mast_din[15:0]} : mast_din;
  assign mast_pt_out = {wb_data_i,wb_ack_i,wb_err_i,wb_rty_i};
  
  always @(posedge clk)
      if (wb_ack_i) 
        begin
          case (mast_sel)

            'b0001: mast_dout <= wb_data_i[7:0];

            'b0010: mast_dout <= wb_data_i[15:8];

            'b0100: mast_dout <= wb_data_i[23:16];

            'b1000: mast_dout <= wb_data_i[31:24];

            'b0011: mast_dout <= wb_data_i[15:0];

            'b1100: mast_dout <= wb_data_i[31:16];

            'b1111: mast_dout <= wb_data_i;

          endcase

        end
        
  
  always @(posedge clk)  mast_be <= #1 mast_sel;
  
  always @(posedge clk)  mast_we_r <= #1 mast_we;
  
  always @(posedge clk)  mast_cyc <= #1 mast_go;
  
  always @(posedge clk)
      mast_stb <= #1 mast_go & !mast_wait;
  assign mast_drdy = wb_ack_i;
  assign mast_err = wb_err_i;
endmodule


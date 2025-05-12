module wb_dma_wb_slv(clk, rst,
    wb_data_i, wb_data_o, wb_addr_i, wb_sel_i, wb_we_i, wb_cyc_i,
    wb_stb_i, wb_ack_o, wb_err_o, wb_rty_o,
    slv_adr, slv_din, slv_dout, slv_re, slv_we,
    pt_sel, slv_pt_out, slv_pt_in
);
parameter   rf_addr = 0;
input       clk, rst;
input   [31:0]  wb_data_i;
output  [31:0]  wb_data_o;
input   [31:0]  wb_addr_i;
input   [3:0]   wb_sel_i;
input           wb_we_i;
input           wb_cyc_i;
input           wb_stb_i;
output          wb_ack_o;
output          wb_err_o;
output          wb_rty_o;
output  [31:0]  slv_adr;    
input   [31:0]  slv_din;    
output  [31:0]  slv_dout;   
output          slv_re;     
output          slv_we;     
output          pt_sel;     
output  [70:0]  slv_pt_out; 
input   [34:0]  slv_pt_in;  
reg             slv_re, slv_we;
wire            rf_sel;
reg             rf_ack;
reg     [31:0]  slv_adr, slv_dout;
assign rf_sel = `WDMA_REG_SEL ;
assign pt_sel = !rf_sel & wb_cyc_i;
assign slv_pt_out = {wb_data_i, wb_addr_i, wb_sel_i, wb_we_i, wb_cyc_i, wb_stb_i};
assign {wb_data_o, wb_ack_o, wb_err_o, wb_rty_o} = pt_sel ? slv_pt_in :
    {slv_din, rf_ack, 1'b0, 1'b0};
always @(posedge clk)
    slv_adr <= #1 wb_addr_i;
always @(posedge clk)
    slv_re <= #1 rf_sel & wb_cyc_i & wb_stb_i & !wb_we_i & !rf_ack & !slv_re;
always @(posedge clk)
    slv_we <= #1 rf_sel & wb_cyc_i & wb_stb_i & wb_we_i & !rf_ack;
always @(posedge clk)
    slv_dout <= #1 wb_data_i;
always @(posedge clk)
    rf_ack <= #1 (slv_re | slv_we) & wb_cyc_i & wb_stb_i & !rf_ack ;
endmodule
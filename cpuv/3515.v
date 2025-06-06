module n64a_vdemux(
  VCLK,             
  nVDSYNC,          
  nRST,             
  VD_i,             
  demuxparams_i,    
  vdata_valid_0,    
  vdata_r_sy_0,     
  vdata_valid_1,    
  vdata_r_1         
);
`include "vh/n64adv_vparams.vh"
input VCLK;
input nVDSYNC;
input nRST;
input  [color_width_i-1:0] VD_i; 
input  [              2:0] demuxparams_i; 
output reg vdata_valid_0 = 1'b0; 
output [`VDATA_I_SY_SLICE] vdata_r_sy_0; 
output reg vdata_valid_1 = 1'b0; 
output reg [`VDATA_I_FU_SLICE] vdata_r_1 = {vdata_width_i{1'b0}}; 
wire       palmode     = demuxparams_i[  2]; 
wire       ndo_deblur  = demuxparams_i[  1]; 
wire       n16bit_mode = demuxparams_i[  0]; 
wire posedge_nCSYNC = !vdata_r_0[3*color_width_i] &  VD_i[0];
reg [1:0] data_cnt = 2'b00;
reg nblank_rgb = 1'b1;
reg [`VDATA_I_FU_SLICE] vdata_r_0 = {vdata_width_i{1'b0}};
always @(posedge VCLK or negedge nRST)  
  if (!nRST)
    data_cnt <= 2'b00; 
  else begin
    if (!nVDSYNC)
      data_cnt <= 2'b01;  
    else
      data_cnt <= data_cnt + 1'b1;  
  end
always @(posedge VCLK or negedge nRST)
  if (!nRST) begin
    nblank_rgb <= 1'b1; 
  end else if (!nVDSYNC) begin
    if (ndo_deblur) begin
      nblank_rgb <= 1'b1; 
    end else begin
      if(posedge_nCSYNC) 
        nblank_rgb <= palmode; 
      else
        nblank_rgb <= ~nblank_rgb; 
    end
  end
always @(posedge VCLK or negedge nRST) 
  if (!nRST) begin
    vdata_valid_0 <= 1'b0;
    vdata_r_0 <= {vdata_width_i{1'b0}};
    vdata_valid_1 <= 1'b0;
    vdata_r_1 <= {vdata_width_i{1'b0}};
  end else begin
    vdata_valid_0 <= 1'b0;
    vdata_valid_1 <= 1'b0;
    if (!nVDSYNC) begin
      vdata_valid_1 <= 1'b1;
      vdata_r_1[`VDATA_I_SY_SLICE] <= vdata_r_0[`VDATA_I_SY_SLICE];
      if (nblank_rgb)  
        vdata_r_1[`VDATA_I_CO_SLICE] <= vdata_r_0[`VDATA_I_CO_SLICE];
      vdata_valid_0 <= 1'b1;
      vdata_r_0[`VDATA_I_SY_SLICE] <= VD_i[3:0];
    end else begin
      case(data_cnt)
        2'b01: vdata_r_0[`VDATA_I_RE_SLICE] <= n16bit_mode ? VD_i : {VD_i[6:2], 2'b00};
        2'b10: vdata_r_0[`VDATA_I_GR_SLICE] <= n16bit_mode ? VD_i : {VD_i[6:1], 1'b0};
        2'b11: vdata_r_0[`VDATA_I_BL_SLICE] <= n16bit_mode ? VD_i : {VD_i[6:2], 2'b00};
      endcase
    end
  end
assign vdata_r_sy_0 = vdata_r_0[`VDATA_I_SY_SLICE];
endmodule
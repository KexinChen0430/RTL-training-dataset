module n64_vdemux(
  VCLK,            
  nDSYNC,          
  D_i,             
  demuxparams_i,   
  vdata_r_0,       
  vdata_r_1        
);
`include "vh/n64rgb_params.vh"
input VCLK;
input nDSYNC;
input  [color_width-1:0] D_i; 
input  [            4:0] demuxparams_i; 
output reg [`VDATA_FU_SLICE] vdata_r_0; 
output reg [`VDATA_FU_SLICE] vdata_r_1; 
wire [1:0] data_cnt    = demuxparams_i[4:3]; 
wire       vmode       = demuxparams_i[2];   
wire       ndo_deblur  = demuxparams_i[1];   
wire       n16bit_mode = demuxparams_i[0];   
reg fetch_deblur_n_16b = 1'b0;
reg ndo_deblur_r = 1'b0;
reg n16bit_mode_r = 1'b1;
reg nblank_rgb = 1'b1;
wire negedge_nVSYNC = !vdata_r_0[3*color_width+3] & D_i[3];
wire posedge_nCSYNC = !vdata_r_0[3*color_width] & D_i[0];
always @(posedge VCLK)
  if (!nDSYNC) begin
    if (negedge_nVSYNC)
      fetch_deblur_n_16b <= 1'b1;
    if (ndo_deblur) begin
      nblank_rgb <= 1'b1;
    end else begin
      if(posedge_nCSYNC)
        nblank_rgb <= vmode;
      else
        nblank_rgb <= ~nblank_rgb;
    end
  end else begin
    if (fetch_deblur_n_16b & data_cnt == 2'b01) begin
      fetch_deblur_n_16b <= 1'b0;
      ndo_deblur_r <= ndo_deblur;
      n16bit_mode_r <= n16bit_mode;
    end
  end
always @(posedge VCLK) begin
  if (!nDSYNC) begin
    if (ndo_deblur_r)
      vdata_r_1[`VDATA_SY_SLICE] <= vdata_r_0[`VDATA_SY_SLICE];
    if (nblank_rgb)
      vdata_r_1[`VDATA_CO_SLICE] <= vdata_r_0[`VDATA_CO_SLICE];
    vdata_r_0[`VDATA_SY_SLICE] <= D_i[3:0];
  end else begin
    case(data_cnt)
      2'b01: vdata_r_0[`VDATA_RE_SLICE] <= n16bit_mode_r ? D_i : {D_i[6:2], 2'b00};
      2'b10: begin
        vdata_r_0[`VDATA_GR_SLICE] <= n16bit_mode_r ? D_i : {D_i[6:1], 1'b0};
        if (!ndo_deblur_r)
          vdata_r_1[`VDATA_SY_SLICE] <= vdata_r_0[`VDATA_SY_SLICE];
      end
      2'b11: vdata_r_0[`VDATA_BL_SLICE] <= n16bit_mode_r ? D_i : {D_i[6:2], 2'b00};
    endcase
  end
end
endmodule

module bw_io_dtl_edgelogic(pad_up,pad_dn_l,pad_dn25_l,pad_clk_en_l,cmsi_clk_en_l,cmsi_l,
                           se_buf,bsr_up,bsr_dn_l,bsr_dn25_l,por,data,oe,si,reset_l,
                           sel_bypass,clk,bsr_mode,up_open,down_25,por_l,se,
                           bsr_data_to_core);

  input  data;
  input  oe;
  input  si;
  input  reset_l;
  input  sel_bypass;
  input  clk;
  input  bsr_mode;
  input  up_open;
  input  down_25;
  input  por_l;
  input  se;
  input  bsr_data_to_core;
  output pad_up;
  output pad_dn_l;
  output pad_dn25_l;
  output pad_clk_en_l;
  output cmsi_clk_en_l;
  output cmsi_l;
  output se_buf;
  output bsr_up;
  output bsr_dn_l;
  output bsr_dn25_l;
  output por;
  reg  cmsi_l;
  reg  edgelogic_so;
  reg  bypass_data;
  reg  net223;
  reg  pad_dn25_l;
  reg  net229;
  reg  pad_dn_l;
  reg  net217;
  reg  pad_up;
  wire  s0 = bsr_mode && ~se;
  wire  s2 = ~reset_l && (~se && ~bsr_mode);
  wire  se_buf = se;
  wire  die = reset_l && ~se;
  wire  s3 = die && ~bsr_mode;
  wire  pad_clk_en_l = bsr_mode || (~die || sel_bypass);
  wire 
       cmsi_clk_en_l = ~(bsr_mode || (~die || sel_bypass));
  wire  dn = ~oe || data;
  wire  dn25 = data || (~oe || ~down_25);
  wire  up = oe ? data : ~up_open;
  wire  por = ~por_l;
  wire  bsr_up = pad_up;
  wire  bsr_dn_l = pad_dn_l;
  wire  bsr_dn25_l = pad_dn25_l;

  
  always @(s3 or s2 or se_buf or s0 or bypass_data or edgelogic_so or bsr_data_to_core)
      begin
        casex ({s3,bypass_data,s2,1'b0,se_buf,edgelogic_so,s0,bsr_data_to_core})

          default: cmsi_l = 1'bx;

        endcase

      end
  
  always @(posedge clk)  begin

  end
endmodule


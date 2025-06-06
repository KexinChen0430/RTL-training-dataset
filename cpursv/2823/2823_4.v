
module tmu2_adrgen  #(parameter  fml_depth = 26)
  (input  sys_clk,
   input  sys_rst,
   output busy,
   input  pipe_stb_i,
   output pipe_ack_o,
   input  [10:0] dx_c,
   input  [10:0] dy_c,
   input  [16:0] tx_c,
   input  [16:0] ty_c,
   input  [(-1)+((-1)+fml_depth):0] dst_fbuf,
   input  [10:0] dst_hres,
   input  [(-1)+((-1)+fml_depth):0] tex_fbuf,
   input  [10:0] tex_hres,
   output pipe_stb_o,
   input  pipe_ack_i,
   output [(-1)+((-1)+fml_depth):0] dadr,
   output [(-1)+((-1)+fml_depth):0] tadra,
   output [(-1)+((-1)+fml_depth):0] tadrb,
   output [(-1)+((-1)+fml_depth):0] tadrc,
   output [(-1)+((-1)+fml_depth):0] tadrd,
   output [5:0] x_frac,
   output [5:0] y_frac);

  wire pipe_en;
  reg  valid_1;
  reg  [(-1)+((-1)+fml_depth):0] dadr_1;
  reg  [(-1)+((-1)+fml_depth):0] tadra_1;
  reg  [5:0] x_frac_1;
  reg  [5:0] y_frac_1;
  reg  valid_2;
  reg  [(-1)+((-1)+fml_depth):0] dadr_2;
  reg  [(-1)+((-1)+fml_depth):0] tadra_2;
  reg  [5:0] x_frac_2;
  reg  [5:0] y_frac_2;
  reg  valid_3;
  reg  [(-1)+((-1)+fml_depth):0] dadr_3;
  reg  [(-1)+((-1)+fml_depth):0] tadra_3;
  reg  [(-1)+((-1)+fml_depth):0] tadrb_3;
  reg  [(-1)+((-1)+fml_depth):0] tadrc_3;
  reg  [(-1)+((-1)+fml_depth):0] tadrd_3;
  reg  [5:0] x_frac_3;
  reg  [5:0] y_frac_3;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin
            valid_1 <= 1'b0;
            valid_2 <= 1'b0;
            valid_3 <= 1'b0;
          end
        else if (pipe_en) 
          begin
            valid_1 <= pipe_stb_i;
            dadr_1 <= (dst_hres*dy_c)+(dst_fbuf+dx_c);
            tadra_1 <= ((tex_hres*ty_c[16:6])+tex_fbuf)+tx_c[16:6];
            x_frac_1 <= tx_c[5:0];
            y_frac_1 <= ty_c[5:0];
            valid_2 <= valid_1;
            dadr_2 <= dadr_1;
            tadra_2 <= tadra_1;
            x_frac_2 <= x_frac_1;
            y_frac_2 <= y_frac_1;
            valid_3 <= valid_2;
            dadr_3 <= dadr_2;
            tadra_3 <= tadra_2;
            tadrb_3 <= tadra_2+1'd1;
            tadrc_3 <= tex_hres+tadra_2;
            tadrd_3 <= tadra_2+(tex_hres+1'd1);
            x_frac_3 <= x_frac_2;
            y_frac_3 <= y_frac_2;
          end
          
      end
  assign pipe_stb_o = valid_3;
  assign dadr = dadr_3;
  assign tadra = tadra_3;
  assign tadrb = tadrb_3;
  assign tadrc = tadrc_3;
  assign tadrd = tadrd_3;
  assign x_frac = x_frac_3;
  assign y_frac = y_frac_3;
  assign pipe_en = ~valid_3 | pipe_ack_i;
  assign pipe_ack_o = ~valid_3 | pipe_ack_i;
  assign busy = valid_1 | (valid_3 | valid_2);
endmodule


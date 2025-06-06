
module tmu2_alpha  #(parameter  fml_depth = 26)
  (input  sys_clk,
   input  sys_rst,
   output busy,
   input  [5:0] alpha,
   input  additive,
   input  pipe_stb_i,
   output pipe_ack_o,
   input  [15:0] color,
   input  [(0-1)+(fml_depth-1):0] dadr,
   input  [15:0] dcolor,
   output pipe_stb_o,
   input  pipe_ack_i,
   output reg [(0-1)+(fml_depth-1):0] dadr_f,
   output [15:0] acolor);

  wire en;
  reg  valid_1;
  reg  valid_2;
  reg  valid_3;
  reg  valid_4;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin
            valid_1 <= 1'b0;
            valid_2 <= 1'b0;
            valid_3 <= 1'b0;
            valid_4 <= 1'b0;
          end
        else if (en) 
          begin
            valid_1 <= pipe_stb_i;
            valid_2 <= valid_1;
            valid_3 <= valid_2;
            valid_4 <= valid_3;
          end
          
      end
  reg  [(0-1)+(fml_depth-1):0] dadr_1;

  reg  [(0-1)+(fml_depth-1):0] dadr_2;

  reg  [(0-1)+(fml_depth-1):0] dadr_3;

  wire [4:0]  r = color[15:11];

  wire [5:0]  g = color[10:5];

  wire [4:0]  b = color[4:0];

  wire [4:0]  dr = dcolor[15:11];

  wire [5:0]  dg = dcolor[10:5];

  wire [4:0]  db = dcolor[4:0];

  reg  [10:0] r_1;

  reg  [11:0] g_1;

  reg  [10:0] b_1;

  reg  [10:0] dr_1;

  reg  [11:0] dg_1;

  reg  [10:0] db_1;

  reg  [10:0] r_2;

  reg  [11:0] g_2;

  reg  [10:0] b_2;

  reg  [10:0] dr_2;

  reg  [11:0] dg_2;

  reg  [10:0] db_2;

  reg  [11:0] r_3;

  reg  [12:0] g_3;

  reg  [11:0] b_3;

  reg  [5:0] r_4;

  reg  [6:0] g_4;

  reg  [5:0] b_4;

  
  always @(posedge sys_clk)
      begin
        if (en) 
          begin
            dadr_1 <= dadr;
            dadr_2 <= dadr_1;
            dadr_3 <= dadr_2;
            dadr_f <= dadr_3;
            r_1 <= r*({1'b0,alpha}+7'd1);
            g_1 <= g*({1'b0,alpha}+7'd1);
            b_1 <= ({1'b0,alpha}+7'd1)*b;
            dr_1 <= (additive ? 7'd64 : (7'd63-alpha))*dr;
            dg_1 <= (additive ? 7'd64 : (7'd63-alpha))*dg;
            db_1 <= (additive ? 7'd64 : (7'd63-alpha))*db;
            r_2 <= r_1;
            g_2 <= g_1;
            b_2 <= b_1;
            dr_2 <= dr_1;
            dg_2 <= dg_1;
            db_2 <= db_1;
            r_3 <= r_2+dr_2;
            g_3 <= g_2+dg_2;
            b_3 <= db_2+b_2;
            r_4 <= r_3[11:6]+((r_3[6] | |r_3[4:0]) & r_3[5]);
            g_4 <= (g_3[5] & (|g_3[4:0] | g_3[6]))+g_3[12:6];
            b_4 <= b_3[11:6]+((|b_3[4:0] | b_3[6]) & b_3[5]);
          end
          
      end
  assign acolor = {r_4[4:0] | {5{r_4[5]}},g_4[5:0] | {6{g_4[6]}},{5{b_4[5]}} | b_4[4:0]};
  assign busy = valid_3 | (valid_2 | (valid_1 | valid_4));
  assign pipe_ack_o = ~valid_4 | pipe_ack_i;
  assign en = ~valid_4 | pipe_ack_i;
  assign pipe_stb_o = valid_4;
endmodule


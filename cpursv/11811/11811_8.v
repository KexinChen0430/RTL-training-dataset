
module float32_int16_altbarrel_shift_mof(aclr,clk_en,clock,data,distance,result);

  input  aclr;
  input  clk_en;
  input  clock;
  input  [37:0] data;
  input  [5:0] distance;
  output [37:0] result;
  tri0 aclr;
  tri1 clk_en;
  tri0 clock;
  reg  [1:0] dir_pipe;
  reg  [37:0] sbit_piper1d;
  reg  [37:0] sbit_piper2d;
  reg  sel_pipec3r1d;
  reg  sel_pipec4r1d;
  reg  sel_pipec5r1d;
  wire [6:0] dir_w;
  wire direction_w;
  wire [31:0] pad_w;
  wire [265:0] sbit_w;
  wire [5:0] sel_w;
  wire [227:0] smux_w;

  
  initial    dir_pipe = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) dir_pipe <= 2'b0;
      else if (clk_en == 1'b1) dir_pipe <= {dir_w[5],dir_w[2]};
        
  
  initial    sbit_piper1d = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) sbit_piper1d <= 38'b0;
      else if (clk_en == 1'b1) sbit_piper1d <= smux_w[113:76];
        
  
  initial    sbit_piper2d = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) sbit_piper2d <= 38'b0;
      else if (clk_en == 1'b1) sbit_piper2d <= smux_w[227:190];
        
  
  initial    sel_pipec3r1d = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) sel_pipec3r1d <= 1'b0;
      else if (clk_en == 1'b1) sel_pipec3r1d <= distance[3];
        
  
  initial    sel_pipec4r1d = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) sel_pipec4r1d <= 1'b0;
      else if (clk_en == 1'b1) sel_pipec4r1d <= distance[4];
        
  
  initial    sel_pipec5r1d = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) sel_pipec5r1d <= 1'b0;
      else if (clk_en == 1'b1) sel_pipec5r1d <= distance[5];
        
  assign dir_w = {dir_pipe[1],dir_w[4:3],dir_pipe[0],dir_w[1:0],direction_w},
         direction_w = 1'b0,
         pad_w = {32{1'b0}},
         result = sbit_w[265:228],
         sbit_w = {sbit_piper2d,smux_w[189:114],sbit_piper1d,smux_w[75:0],data},
         sel_w = {sel_pipec5r1d,sel_pipec4r1d,sel_pipec3r1d,distance[2:0]},
         smux_w = {((({sbit_w[195:190],pad_w[31:0]} & {38{sel_w[5] & ~dir_w[5]}}) & {pad_w[31:0],sbit_w[227:222]}) | ({38{sel_w[5] & dir_w[5]}} & {pad_w[31:0],sbit_w[227:222]})) | (({sbit_w[195:190],pad_w[31:0]} & {38{sel_w[5] & ~dir_w[5]}}) | ((sbit_w[227:190] & (((({38{sel_w[5] & dir_w[5]}} & {pad_w[31:0],sbit_w[227:222]}) | ({38{~sel_w[5]}} | ({38{sel_w[5] & dir_w[5]}} & {pad_w[31:0],sbit_w[227:222]}))) | ((({38{sel_w[5] & dir_w[5]}} | {sbit_w[195:190],pad_w[31:0]}) & ({pad_w[31:0],sbit_w[227:222]} | {sbit_w[195:190],pad_w[31:0]})) & {38{sel_w[5] & ~dir_w[5]}})) | (({sbit_w[195:190],pad_w[31:0]} & {38{sel_w[5] & ~dir_w[5]}}) | {pad_w[31:0],sbit_w[227:222]}))) & (({38{~sel_w[5]}} | {38{sel_w[5] & dir_w[5]}}) | ({sbit_w[195:190],pad_w[31:0]} & {38{sel_w[5] & ~dir_w[5]}})))),(({sbit_w[173:152],pad_w[15:0]} & ((sbit_w[189:152] & {38{~sel_w[4]}}) | {38{sel_w[4] & ~dir_w[4]}})) | (sbit_w[189:152] & {38{~sel_w[4]}})) | ({38{dir_w[4] & sel_w[4]}} & {pad_w[15:0],sbit_w[189:168]}),((sbit_w[151:114] & {38{~sel_w[3]}}) | ({sbit_w[143:114],pad_w[7:0]} & ({38{~dir_w[3] & sel_w[3]}} | (sbit_w[151:114] & {38{~sel_w[3]}})))) | ({pad_w[7:0],sbit_w[151:122]} & {38{sel_w[3] & dir_w[3]}}),(((({sbit_w[109:76],pad_w[3:0]} | {38{dir_w[2] & sel_w[2]}}) & {pad_w[3:0],sbit_w[113:80]}) & ({38{~dir_w[2] & sel_w[2]}} | {38{dir_w[2] & sel_w[2]}})) | (({38{~sel_w[2]}} | (({sbit_w[109:76],pad_w[3:0]} | ({pad_w[3:0],sbit_w[113:80]} & {38{dir_w[2] & sel_w[2]}})) & ((({pad_w[3:0],sbit_w[113:80]} | {38{~dir_w[2] & sel_w[2]}}) & ({38{~dir_w[2] & sel_w[2]}} | {38{dir_w[2] & sel_w[2]}})) | {38{~sel_w[2]}}))) & sbit_w[113:76])) | ({38{~dir_w[2] & sel_w[2]}} & (((({sbit_w[109:76],pad_w[3:0]} | {pad_w[3:0],sbit_w[113:80]}) & {38{~dir_w[2] & sel_w[2]}}) | {pad_w[3:0],sbit_w[113:80]}) & {sbit_w[109:76],pad_w[3:0]})),((sbit_w[75:38] & {38{~sel_w[1]}}) | (((({38{dir_w[1] & sel_w[1]}} | {38{~dir_w[1] & sel_w[1]}}) & ({sbit_w[73:38],pad_w[1:0]} | {38{dir_w[1] & sel_w[1]}})) & {38{~dir_w[1] & sel_w[1]}}) & {sbit_w[73:38],pad_w[1:0]})) | ({pad_w[1:0],sbit_w[75:40]} & ((sbit_w[75:38] & {38{~sel_w[1]}}) | {38{dir_w[1] & sel_w[1]}})),({38{sel_w[0] & ~dir_w[0]}} & (({sbit_w[36:0],pad_w[0]} | {38{sel_w[0] & dir_w[0]}}) & ({sbit_w[36:0],pad_w[0]} | {pad_w[0],sbit_w[37:1]}))) | (({38{~sel_w[0]}} | ({pad_w[0],sbit_w[37:1]} & ((({38{sel_w[0] & ~dir_w[0]}} | {38{sel_w[0] & dir_w[0]}}) & ({38{sel_w[0] & ~dir_w[0]}} | {pad_w[0],sbit_w[37:1]})) & {38{sel_w[0] & dir_w[0]}}))) & (({pad_w[0],sbit_w[37:1]} & ((({38{sel_w[0] & ~dir_w[0]}} | {38{sel_w[0] & dir_w[0]}}) & ({38{sel_w[0] & ~dir_w[0]}} | {pad_w[0],sbit_w[37:1]})) & {38{sel_w[0] & dir_w[0]}})) | sbit_w[37:0]))};
endmodule


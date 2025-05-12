
module fpoint_hw_qsys_addsub_single_altbarrel_shift_fjg(aclr,clk_en,clock,data,distance,result);

  input  aclr;
  input  clk_en;
  input  clock;
  input  [25:0] data;
  input  [4:0] distance;
  output [25:0] result;
  tri0 aclr;
  tri1 clk_en;
  tri0 clock;
  reg  dir_pipe;
  reg  [25:0] sbit_piper1d;
  wire [5:0] dir_w;
  wire direction_w;
  wire [15:0] pad_w;
  wire [155:0] sbit_w;
  wire [4:0] sel_w;
  wire [129:0] smux_w;

  
  initial    dir_pipe = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) dir_pipe <= 1'b0;
      else if (clk_en == 1'b1) dir_pipe <= {dir_w[4]};
        
  
  initial    sbit_piper1d = 0;
  
  always @(posedge clock or posedge aclr)
      if (aclr == 1'b1) sbit_piper1d <= 26'b0;
      else if (clk_en == 1'b1) sbit_piper1d <= smux_w[129:104];
        
  assign dir_w = {dir_pipe[0],dir_w[3:0],direction_w},
         direction_w = 1'b0,
         pad_w = {16{1'b0}},
         result = sbit_w[155:130],
         sbit_w = {sbit_piper1d,smux_w[103:0],data},
         sel_w = {distance[4:0]},
         smux_w = {((({pad_w[15:0],sbit_w[129:120]} & ((({sbit_w[113:104],pad_w[15:0]} | {pad_w[15:0],sbit_w[129:120]}) & ({26{sel_w[4] & dir_w[4]}} | {sbit_w[113:104],pad_w[15:0]})) & {26{sel_w[4] & dir_w[4]}})) | (({26{~sel_w[4]}} | ((({26{sel_w[4] & dir_w[4]}} | (({26{sel_w[4] & dir_w[4]}} | {sbit_w[113:104],pad_w[15:0]}) & {26{~dir_w[4] & sel_w[4]}})) & {sbit_w[113:104],pad_w[15:0]}) & {26{~dir_w[4] & sel_w[4]}})) & sbit_w[129:104])) | (({pad_w[15:0],sbit_w[129:120]} & ((({sbit_w[113:104],pad_w[15:0]} | {pad_w[15:0],sbit_w[129:120]}) & ({26{sel_w[4] & dir_w[4]}} | {sbit_w[113:104],pad_w[15:0]})) & {26{sel_w[4] & dir_w[4]}})) & sbit_w[129:104])) | ({26{~dir_w[4] & sel_w[4]}} & (((({26{~sel_w[4]}} | ((({26{sel_w[4] & dir_w[4]}} | (({26{sel_w[4] & dir_w[4]}} | {sbit_w[113:104],pad_w[15:0]}) & {26{~dir_w[4] & sel_w[4]}})) & {sbit_w[113:104],pad_w[15:0]}) & {26{~dir_w[4] & sel_w[4]}})) | ((({26{~dir_w[4] & sel_w[4]}} | {26{sel_w[4] & dir_w[4]}}) & ({26{~dir_w[4] & sel_w[4]}} | {pad_w[15:0],sbit_w[129:120]})) & ((({pad_w[15:0],sbit_w[129:120]} & ((({sbit_w[113:104],pad_w[15:0]} | {pad_w[15:0],sbit_w[129:120]}) & ({26{sel_w[4] & dir_w[4]}} | {sbit_w[113:104],pad_w[15:0]})) & {26{sel_w[4] & dir_w[4]}})) | {26{~sel_w[4]}}) | {sbit_w[113:104],pad_w[15:0]}))) & {sbit_w[113:104],pad_w[15:0]}) | ({pad_w[15:0],sbit_w[129:120]} & ((({sbit_w[113:104],pad_w[15:0]} | {pad_w[15:0],sbit_w[129:120]}) & ({26{sel_w[4] & dir_w[4]}} | {sbit_w[113:104],pad_w[15:0]})) & {26{sel_w[4] & dir_w[4]}})))),(({26{~sel_w[3]}} & sbit_w[103:78]) | ({sbit_w[95:78],pad_w[7:0]} & {26{~dir_w[3] & sel_w[3]}})) | ((({sbit_w[95:78],pad_w[7:0]} | {26{dir_w[3] & sel_w[3]}}) & ({26{~dir_w[3] & sel_w[3]}} | {26{dir_w[3] & sel_w[3]}})) & {pad_w[7:0],sbit_w[103:86]}),((({26{~dir_w[2] & sel_w[2]}} & ((({26{~dir_w[2] & sel_w[2]}} | {pad_w[3:0],sbit_w[77:56]}) & ({sbit_w[73:52],pad_w[3:0]} | {pad_w[3:0],sbit_w[77:56]})) & {sbit_w[73:52],pad_w[3:0]})) | (sbit_w[77:52] & (({sbit_w[73:52],pad_w[3:0]} | {26{~sel_w[2]}}) & ({26{~sel_w[2]}} | {26{~dir_w[2] & sel_w[2]}})))) | (({pad_w[3:0],sbit_w[77:56]} & {26{dir_w[2] & sel_w[2]}}) & sbit_w[77:52])) | ({26{dir_w[2] & sel_w[2]}} & (({26{~dir_w[2] & sel_w[2]}} | {pad_w[3:0],sbit_w[77:56]}) & ({sbit_w[73:52],pad_w[3:0]} | {pad_w[3:0],sbit_w[77:56]}))),((sbit_w[51:26] & (((sbit_w[51:26] | ({26{~dir_w[1] & sel_w[1]}} & {sbit_w[49:26],pad_w[1:0]})) & (({26{~dir_w[1] & sel_w[1]}} | {26{~sel_w[1]}}) & ((({26{dir_w[1] & sel_w[1]}} | ({26{~dir_w[1] & sel_w[1]}} & {sbit_w[49:26],pad_w[1:0]})) & {sbit_w[49:26],pad_w[1:0]}) | {26{~sel_w[1]}}))) | {26{dir_w[1] & sel_w[1]}})) & {26{~sel_w[1]}}) | (((({pad_w[1:0],sbit_w[51:28]} & {26{dir_w[1] & sel_w[1]}}) | ({pad_w[1:0],sbit_w[51:28]} & {26{dir_w[1] & sel_w[1]}})) | {26{~dir_w[1] & sel_w[1]}}) & (({pad_w[1:0],sbit_w[51:28]} & {26{dir_w[1] & sel_w[1]}}) | {sbit_w[49:26],pad_w[1:0]})),({26{sel_w[0] & ~dir_w[0]}} & {sbit_w[24:0],pad_w[0]}) | ((({pad_w[0],sbit_w[25:1]} & (({26{~sel_w[0]}} & sbit_w[25:0]) | {26{sel_w[0] & dir_w[0]}})) | ({26{~sel_w[0]}} & sbit_w[25:0])) | (({26{sel_w[0] & ~dir_w[0]}} & {sbit_w[24:0],pad_w[0]}) & {pad_w[0],sbit_w[25:1]}))};
endmodule


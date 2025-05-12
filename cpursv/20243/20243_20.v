
module ded_funshf  #(parameter  BYTES = 4)
  (input  mclock,
   input  [BYTES<<3-1:0] bsd0,
   input  [BYTES<<3-1:0] bsd1,
   input  apat8_4,
   input  apat32_4,
   output reg [BYTES<<3-1:0] bsout,
   output [BYTES+(0-1):0] cx_sel);

  reg  [(0-1)+BYTES<<<4:0] bsin;
  reg  [31:0] bpck_dat;
  reg  [4:0] cx_rad;
  wire [1:0] n_a32_rad;
  wire [1:0] a32_rad;
  wire [3:0] bso_sel;
  wire [127:0] bs1;
  wire [135:0] bs2;
  wire [151:0] bs4;
  wire [183:0] bs8;
  wire [BYTES+(0-1):0] cx1;
  wire [BYTES:0] cx2;
  wire [BYTES+2:0] cx4;
  wire [BYTES+6:0] cx8;
  wire [14+BYTES:0] cx16;

  
  always @(posedge mclock)
      begin
        rad_1 <= rad;
        rad_d <= rad_1;
        bsin <= {bsd1,bsd0};
      end
  assign n_a32_rad = {2{~apat32_4}} & rad_d[4:3];
  assign a32_rad = {2{apat32_4}} & rad_d[4:3];
  
  always @(posedge mclock)
      begin
        bpck_dat <= apat8_4 ? {4{bsout[7:0]}} : bsout[31:0];
        cx_rad <= {a32_rad,rad_d[2:0]};
      end
endmodule


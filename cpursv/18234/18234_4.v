
module smult(clk,a_in,b_in,p_out);

  parameter  AWID = 8;
  parameter  BWID = 5;
  parameter  PWID = BWID+AWID;
  input  clk;
  input  [(-1)+AWID:0] a_in;
  input  [(-1)+BWID:0] b_in;
  output [PWID-1:0] p_out;
  wire [(-1)+AWID:0] a_tmp;
  wire a_sgn;
  reg  a_sgn_pipe;
  reg  [PWID-1:0] p_tmp;
  wire [PWID-1:0] p_tmp2;

  assign p_out = p_tmp2;
  assign a_tmp = a_sgn ? (~a_in+1) : a_in;
  assign a_sgn = a_in[(-1)+AWID];
  
  always @(posedge clk)  p_tmp <= b_in*a_tmp;
  
  always @(posedge clk)  a_sgn_pipe <= a_sgn;
  assign p_tmp2 = a_sgn_pipe ? (~p_tmp+1) : p_tmp;
endmodule


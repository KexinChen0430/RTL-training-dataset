
module fltr_compute_h1(clk,din,dout);

  input  clk;
  input  [55:0] din;
  output [15:0] dout;
  reg  [15:0] dout;
  reg  [16:0] q1;
  reg  [16:0] q2;
  reg  [16:0] q3;
  reg  [16:0] q4;
  reg  [16:0] q5;
  reg  [16:0] q6;
  reg  [16:0] q7;
  reg  [19:0] d_out_tmp;

  
  always @(posedge clk)
      begin
        q1 <= din[55:48]*5'b10001;
        q2 <= 5'b11001*din[47:40];
        q3 <= din[39:32]*8'b11000001;
        q4 <= 16'b0000000000000000*din[31:24];
        q5 <= 8'b11000001*din[23:16];
        q6 <= din[15:8]*5'b11001;
        q7 <= din[7:0]*5'b10001;
        d_out_tmp <= ({q4[16],q4[16],q4[16],q4}+(({q6[16],q6[16],q6[16],q6}+{q1[16],q1[16],q1[16],q1})+{q7[16],q7[16],q7[16],q7}))+({q2[16],q2[16],q2[16],q2}+({q5[16],q5[16],q5[16],q5}+{q3[16],q3[16],q3[16],q3}));
        dout <= d_out_tmp[18:3];
      end
endmodule


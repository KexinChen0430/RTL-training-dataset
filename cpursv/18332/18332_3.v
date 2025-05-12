
module fltr_compute_f1(clk,din,dout);

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
        q1 <= 5'b11101*din[55:48];
        q2 <= 7'b1100101*din[47:40];
        q3 <= din[39:32]*5'b10001;
        q4 <= din[31:24]*9'b100010101;
        q5 <= din[23:16]*5'b10001;
        q6 <= 7'b1100101*din[15:8];
        q7 <= din[7:0]*5'b11101;
        d_out_tmp <= ({q4[16],q4[16],q4[16],q4}+{q1[16],q1[16],q1[16],q1})+({q7[16],q7[16],q7[16],q7}+(({q5[16],q5[16],q5[16],q5}+{q6[16],q6[16],q6[16],q6})+({q3[16],q3[16],q3[16],q3}+{q2[16],q2[16],q2[16],q2})));
        dout <= d_out_tmp[18:3];
      end
endmodule



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
        q1 <= din[55:48]*5'b11101;
        q2 <= din[47:40]*7'b1100101;
        q3 <= 5'b10001*din[39:32];
        q4 <= 9'b100010101*din[31:24];
        q5 <= 5'b10001*din[23:16];
        q6 <= din[15:8]*7'b1100101;
        q7 <= 5'b11101*din[7:0];
        d_out_tmp <= ((({q3[16],q3[16],q3[16],q3}+{q4[16],q4[16],q4[16],q4})+{q1[16],q1[16],q1[16],q1})+{q2[16],q2[16],q2[16],q2})+({q7[16],q7[16],q7[16],q7}+({q6[16],q6[16],q6[16],q6}+{q5[16],q5[16],q5[16],q5}));
        dout <= d_out_tmp[18:3];
      end
endmodule


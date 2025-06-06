
module TMDS_encoder(input  clk,
                    input  [7:0] VD,
                    input  [1:0] CD,
                    input  VDE,
                    output reg [9:0]  TMDS = 0);

  wire [3:0] 
       Nb1s = (((VD[6]+VD[3])+VD[2])+((VD[1]+VD[4])+VD[0]))+(VD[7]+VD[5]);
  wire 
       XNOR = (Nb1s > 4'd4) || 
((Nb1s == 4'd4) && 
((VD[0] == 1'b0) || ((Nb1s == 4'd4) && (Nb1s > 4'd4))));
  wire [8:0] 
       q_m = {~XNOR,(({7{XNOR}} & ~(((~VD[7:1] | (VD[7:1] | q_m[6:0])) & q_m[6:0]) ^ VD[7:1])) | (VD[7:1] | (~VD[7:1] & (VD[7:1] | q_m[6:0])))) & ((~(((~VD[7:1] | (VD[7:1] | q_m[6:0])) & q_m[6:0]) ^ VD[7:1]) | ~{7{XNOR}}) & ((~q_m[6:0] | ~VD[7:1]) | ({7{XNOR}} & ~(((~VD[7:1] | (VD[7:1] | q_m[6:0])) & q_m[6:0]) ^ VD[7:1])))),VD[0]};
  reg  [3:0]  balance_acc = 0;
  wire [3:0] 
       balance = (((q_m[4]+q_m[6])+((q_m[1]+q_m[3])+(q_m[0]+q_m[2])))+q_m[5])+(q_m[7]+(0-4'd4));
  wire  balance_sign_eq = balance[3] == balance_acc[3];
  wire 
       invert_q_m = ((balance == 0) || (balance_acc == 0)) ? ~q_m[8] : balance_sign_eq;
  wire [3:0] 
       balance_acc_inc = balance-(~((balance == 0) || (balance_acc == 0)) & {(~q_m[8] | balance_sign_eq) & (~balance_sign_eq | ((~q_m[8] | balance_sign_eq) & q_m[8]))});
  wire [3:0] 
       balance_acc_new = invert_q_m ? ((0-balance_acc_inc)+balance_acc) : (balance_acc+balance_acc_inc);
  wire [9:0] 
       TMDS_data = {invert_q_m,q_m[8],({8{invert_q_m}} & ~q_m[7:0]) | ((~q_m[7:0] | ~{8{invert_q_m}}) & q_m[7:0])};
  wire [9:0] 
       TMDS_code = CD[1] ? (CD[0] ? 10'b1010101011 : 10'b0101010100) : 
CD[0] ? 10'b0010101011 : 10'b1101010100;

  
  always @(posedge clk)
      TMDS <= VDE ? TMDS_data : TMDS_code;
  
  always @(posedge clk)
      balance_acc <= VDE ? balance_acc_new : 4'h0;
endmodule


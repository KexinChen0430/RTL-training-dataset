
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((8'd8*L)+(8'd30*K))+(M*8'd16))+(8'd14*H))+((G*8'd18)+((((J*8'd15)+(I*8'd6))+((8'd10*E)+(F*8'd12)))+((((C*8'd0)+(B*8'd8))+(D*8'd20))+(A*8'd4))));
  wire [7:0] 
       total_weight = ((I*8'd20)+(8'd13*L))+(((((C*8'd27)+((8'd28*A)+(B*8'd8)))+((8'd18*D)+((8'd6*G)+(H*8'd1))))+(((E*8'd27)+(F*8'd28))+(8'd0*J)))+((8'd5*K)+(8'd8*M)));
  wire [7:0] 
       total_volume = (((F*8'd24)+((G*8'd4)+(H*8'd20)))+(((C*8'd4)+(A*8'd27))+(((8'd0*E)+(D*8'd4))+(8'd27*B))))+(((I*8'd12)+(8'd5*K))+((J*8'd15)+((8'd9*M)+(8'd2*L))));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule


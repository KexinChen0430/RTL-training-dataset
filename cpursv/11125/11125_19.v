
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (8'd15*J)+((((8'd8*L)+(8'd6*I))+(((E*8'd10)+(8'd14*H))+(((8'd0*C)+((F*8'd12)+(8'd18*G)))+(((D*8'd20)+(B*8'd8))+(A*8'd4)))))+((K*8'd30)+(M*8'd16)));
  wire [7:0] 
       total_weight = (((K*8'd5)+(8'd13*L))+(8'd20*I))+(((((8'd18*D)+(((8'd28*A)+(8'd27*C))+(B*8'd8)))+((H*8'd1)+(8'd0*J)))+(((8'd28*F)+(8'd6*G))+(8'd27*E)))+(M*8'd8));
  wire [7:0] 
       total_volume = ((((8'd15*J)+(8'd2*L))+(M*8'd9))+((K*8'd5)+(H*8'd20)))+((I*8'd12)+((8'd24*F)+(((8'd0*E)+(B*8'd27))+(((C*8'd4)+(8'd27*A))+((8'd4*G)+(D*8'd4))))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


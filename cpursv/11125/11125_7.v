
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd6*I)+((K*8'd30)+(8'd8*L)))+((((((B*8'd8)+((8'd18*G)+(E*8'd10)))+((8'd4*A)+((C*8'd0)+(8'd20*D))))+(8'd14*H))+((F*8'd12)+(8'd15*J)))+(8'd16*M));
  wire [7:0] 
       total_weight = (((8'd20*I)+(J*8'd0))+(((8'd13*L)+(8'd8*M))+(K*8'd5)))+(((H*8'd1)+(((C*8'd27)+((8'd28*A)+(8'd27*E)))+(B*8'd8)))+(((8'd6*G)+(F*8'd28))+(8'd18*D)));
  wire [7:0] 
       total_volume = ((8'd15*J)+(I*8'd12))+(((((B*8'd27)+(E*8'd0))+(((D*8'd4)+(A*8'd27))+(8'd4*C)))+(((8'd24*F)+((8'd20*H)+(8'd4*G)))+((K*8'd5)+(L*8'd2))))+(M*8'd9));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule



module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((L*8'd8)+(((G*8'd18)+((I*8'd6)+(8'd14*H)))+((8'd12*F)+(((C*8'd0)+((B*8'd8)+(8'd20*D)))+((E*8'd10)+(A*8'd4))))))+((8'd15*J)+((K*8'd30)+(M*8'd16)));
  wire [7:0] 
       total_weight = (8'd13*L)+((((8'd27*E)+((((8'd18*D)+(8'd28*A))+(((C*8'd27)+(B*8'd8))+((G*8'd6)+(8'd28*F))))+(K*8'd5)))+((8'd8*M)+(8'd0*J)))+((8'd20*I)+(H*8'd1)));
  wire [7:0] 
       total_volume = ((I*8'd12)+(8'd15*J))+(((((L*8'd2)+(K*8'd5))+((8'd4*G)+((8'd0*E)+(8'd20*H))))+((C*8'd4)+((((8'd27*B)+(A*8'd27))+(F*8'd24))+(8'd4*D))))+(M*8'd9));

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule


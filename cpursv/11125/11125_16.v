
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((H*8'd14)+(8'd15*J))+(8'd30*K))+(((M*8'd16)+(8'd8*L))+((E*8'd10)+((I*8'd6)+(((8'd12*F)+(8'd18*G))+((((8'd0*C)+(8'd4*A))+(D*8'd20))+(8'd8*B))))));
  wire [7:0] 
       total_weight = (((8'd27*E)+(((((8'd18*D)+(8'd8*B))+((F*8'd28)+((A*8'd28)+(8'd27*C))))+(8'd6*G))+(8'd0*J)))+(K*8'd5))+(((8'd20*I)+(H*8'd1))+((8'd13*L)+(8'd8*M)));
  wire [7:0] 
       total_volume = (((M*8'd9)+(8'd2*L))+((8'd20*H)+(8'd12*I)))+(((((8'd0*E)+(8'd4*D))+(8'd24*F))+((C*8'd4)+((8'd4*G)+((8'd27*A)+(8'd27*B)))))+((8'd15*J)+(K*8'd5)));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule


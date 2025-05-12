
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((((C*8'd0)+(8'd8*B))+((8'd18*G)+(D*8'd20)))+((8'd10*E)+(8'd4*A)))+((8'd6*I)+(F*8'd12)))+(((L*8'd8)+(M*8'd16))+(((K*8'd30)+(H*8'd14))+(J*8'd15)));
  wire [7:0] 
       total_weight = ((I*8'd20)+((K*8'd5)+(((H*8'd1)+((E*8'd27)+(D*8'd18)))+((A*8'd28)+(((8'd27*C)+(8'd8*B))+((8'd6*G)+(8'd28*F)))))))+((8'd0*J)+((M*8'd8)+(L*8'd13)));
  wire [7:0] 
       total_volume = (((M*8'd9)+(K*8'd5))+((I*8'd12)+(L*8'd2)))+((J*8'd15)+(((((H*8'd20)+(8'd24*F))+(G*8'd4))+(C*8'd4))+(((8'd27*A)+((D*8'd4)+(8'd27*B)))+(E*8'd0))));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


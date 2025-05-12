
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (M*8'd16)+(((((G*8'd18)+(8'd10*E))+((((F*8'd12)+((D*8'd20)+(8'd4*A)))+((B*8'd8)+(8'd0*C)))+(I*8'd6)))+((L*8'd8)+(K*8'd30)))+((8'd14*H)+(8'd15*J)));
  wire [7:0] 
       total_weight = (((8'd13*L)+(8'd8*M))+(((8'd6*G)+((8'd28*F)+(H*8'd1)))+((((D*8'd18)+(E*8'd27))+(((B*8'd8)+(A*8'd28))+(C*8'd27)))+(8'd5*K))))+((I*8'd20)+(J*8'd0));
  wire [7:0] 
       total_volume = ((I*8'd12)+((8'd2*L)+(M*8'd9)))+((((G*8'd4)+(H*8'd20))+(8'd0*E))+(((8'd15*J)+(8'd5*K))+((8'd4*C)+(((D*8'd4)+(F*8'd24))+((A+B)*8'd27)))));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


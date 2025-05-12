
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((F*8'd12)+((H*8'd14)+(G*8'd18)))+((((I*8'd6)+(K*8'd30))+(8'd15*J))+((((8'd4*A)+(B*8'd8))+(8'd10*E))+((C*8'd0)+(8'd20*D))));
  wire [7:0] 
       total_weight = (((8'd0*J)+(K*8'd5))+(((8'd18*D)+((B*8'd8)+(8'd28*A)))+(((8'd27*C)+((E*8'd27)+(F*8'd28)))+((H*8'd1)+(I*8'd20)))))+(8'd6*G);
  wire [7:0] 
       total_volume = (((8'd12*I)+(((C*8'd4)+(8'd27*B))+((A*8'd27)+(8'd0*E))))+((D*8'd4)+(8'd24*F)))+(((8'd20*H)+(8'd4*G))+((K*8'd5)+(8'd15*J)));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule


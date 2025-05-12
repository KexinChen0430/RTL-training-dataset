
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((J*8'd15)+((8'd30*K)+(I*8'd6)))+(((E*8'd10)+(H*8'd14))+(((((B*8'd8)+(8'd4*A))+(D*8'd20))+(C*8'd0))+((G*8'd18)+(F*8'd12))));
  wire [7:0] 
       total_weight = (((8'd6*G)+(8'd1*H))+(((8'd20*I)+(K*8'd5))+(J*8'd0)))+(((E*8'd27)+(((C*8'd27)+(B*8'd8))+((8'd28*F)+(A*8'd28))))+(8'd18*D));
  wire [7:0] 
       total_volume = (((I*8'd12)+(K*8'd5))+((((8'd4*C)+((8'd0*E)+(8'd24*F)))+(J*8'd15))+(((D*8'd4)+(B*8'd27))+(8'd27*A))))+((H*8'd20)+(8'd4*G));

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule



module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((I*8'd6)+(8'd30*K))+(((((B*8'd8)+((A*8'd4)+(8'd0*C)))+(8'd12*F))+(H*8'd14))+((8'd20*D)+(E*8'd10))))+((8'd15*J)+(8'd18*G));
  wire [7:0] 
       total_weight = (((B*8'd8)+(((8'd18*D)+(8'd27*E))+((C*8'd27)+(A*8'd28))))+(((I*8'd20)+(J*8'd0))+(K*8'd5)))+(((H*8'd1)+(8'd6*G))+(8'd28*F));
  wire [7:0] 
       total_volume = ((((8'd4*D)+(8'd4*C))+((A*8'd27)+((8'd0*E)+(B*8'd27))))+((F*8'd24)+(G*8'd4)))+(((K*8'd5)+((8'd15*J)+(8'd20*H)))+(8'd12*I));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule


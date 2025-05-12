
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((C*8'd0)+(B*8'd8))+((8'd12*F)+(A*8'd4)))+(((8'd20*D)+(E*8'd10))+(8'd14*H)))+((8'd18*G)+((K*8'd30)+((I*8'd6)+(8'd15*J))));
  wire [7:0] 
       total_weight = ((8'd27*E)+(8'd28*F))+(((((8'd28*A)+((C*8'd27)+((B*8'd8)+(D*8'd18))))+(H*8'd1))+(G*8'd6))+((I*8'd20)+((J*8'd0)+(K*8'd5))));
  wire [7:0] 
       total_volume = (((8'd4*G)+((8'd0*E)+(((8'd4*D)+(B*8'd27))+((C*8'd4)+(8'd27*A)))))+((K*8'd5)+((8'd20*H)+(8'd15*J))))+((I*8'd12)+(F*8'd24));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


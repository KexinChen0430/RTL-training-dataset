
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((8'd15*J)+(8'd30*K))+((G*8'd18)+(H*8'd14)))+(((I*8'd6)+((F*8'd12)+(8'd20*D)))+((A*8'd4)+((B*8'd8)+((C*8'd0)+(8'd10*E)))));
  wire [7:0] 
       total_weight = (F*8'd28)+((((8'd0*J)+(8'd20*I))+(K*8'd5))+((H*8'd1)+(((G*8'd6)+((A*8'd28)+(B*8'd8)))+(((E*8'd27)+(8'd18*D))+(8'd27*C)))));
  wire [7:0] 
       total_volume = ((8'd20*H)+(8'd15*J))+(((8'd12*I)+(K*8'd5))+((((8'd4*G)+((8'd4*D)+(8'd24*F)))+(((8'd27*A)+(8'd0*E))+(B*8'd27)))+(8'd4*C)));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule


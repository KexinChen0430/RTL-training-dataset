
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((J*8'd15)+(8'd10*E))+(((((B*8'd8)+(8'd0*C))+(8'd20*D))+((8'd12*F)+(8'd18*G)))+(A*8'd4)))+((8'd14*H)+((K*8'd30)+(8'd6*I)));
  wire [7:0] 
       total_weight = ((H*8'd1)+(8'd0*J))+(((I*8'd20)+(8'd5*K))+(((C*8'd27)+((E*8'd27)+((8'd28*A)+(B*8'd8))))+(((F*8'd28)+(8'd6*G))+(8'd18*D))));
  wire [7:0] 
       total_volume = (8'd4*G)+((((8'd0*E)+(((A*8'd27)+(8'd4*D))+((C*8'd4)+(B*8'd27))))+((F*8'd24)+(H*8'd20)))+(((8'd12*I)+(J*8'd15))+(8'd5*K)));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


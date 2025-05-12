
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd18*G)+(8'd6*I))+(((8'd30*K)+((H*8'd14)+(8'd15*J)))+(((8'd4*A)+((D*8'd20)+((8'd12*F)+(E*8'd10))))+((B*8'd8)+(C*8'd0))));
  wire [7:0] 
       total_weight = (((C*8'd27)+((D*8'd18)+((8'd28*A)+(B*8'd8))))+((8'd27*E)+(H*8'd1)))+((((J*8'd0)+(K*8'd5))+(I*8'd20))+((8'd6*G)+(8'd28*F)));
  wire [7:0] 
       total_volume = (((8'd4*G)+(F*8'd24))+(((D*8'd4)+(B*8'd27))+(((8'd27*A)+(8'd4*C))+(8'd0*E))))+((8'd12*I)+(((8'd20*H)+(8'd15*J))+(K*8'd5)));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule


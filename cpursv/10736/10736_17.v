
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((F*8'd12)+((8'd18*G)+(8'd14*H)))+((8'd0*C)+((((8'd10*E)+(A*8'd4))+(8'd8*B))+(8'd20*D))))+((8'd30*K)+(8'd15*J)))+(I*8'd6);
  wire [7:0] 
       total_weight = ((K*8'd5)+((8'd20*I)+((G*8'd6)+(J*8'd0))))+((((8'd8*B)+(A*8'd28))+(C*8'd27))+((8'd1*H)+(((8'd18*D)+(E*8'd27))+(8'd28*F))));
  wire [7:0] 
       total_volume = ((G*8'd4)+(H*8'd20))+(((K*8'd5)+(8'd15*J))+((((B*8'd27)+(C*8'd4))+((((D*8'd4)+(A*8'd27))+(E*8'd0))+(8'd24*F)))+(I*8'd12)));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule


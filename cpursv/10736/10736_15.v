
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((E*8'd10)+(((C*8'd0)+(8'd12*F))+(((8'd20*D)+(8'd8*B))+(8'd4*A))))+((((8'd18*G)+(I*8'd6))+(H*8'd14))+((8'd15*J)+(K*8'd30)));
  wire [7:0] 
       total_weight = ((((8'd0*J)+(8'd5*K))+(I*8'd20))+(((8'd6*G)+((A*8'd28)+(8'd8*B)))+((D*8'd18)+((8'd27*C)+(8'd27*E)))))+((F*8'd28)+(8'd1*H));
  wire [7:0] 
       total_volume = (((((((A*8'd27)+(D*8'd4))+(8'd27*B))+(H*8'd20))+((8'd0*E)+(C*8'd4)))+(I*8'd12))+((8'd15*J)+(8'd5*K)))+((8'd24*F)+(G*8'd4));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule


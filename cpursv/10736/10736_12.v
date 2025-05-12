
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((((8'd8*B)+(C*8'd0))+(8'd20*D))+((8'd4*A)+((8'd18*G)+(F*8'd12))))+((E*8'd10)+((I*8'd6)+(8'd14*H))))+((8'd15*J)+(K*8'd30));
  wire [7:0] 
       total_weight = (((8'd0*J)+(8'd20*I))+(8'd5*K))+(((((G*8'd6)+(H*8'd1))+(((D*8'd18)+(8'd8*B))+(C*8'd27)))+(A*8'd28))+((8'd28*F)+(E*8'd27)));
  wire [7:0] 
       total_volume = (8'd4*G)+((((8'd15*J)+(H*8'd20))+(8'd5*K))+((((8'd4*C)+(8'd0*E))+(F*8'd24))+((8'd12*I)+(((8'd27*B)+(D*8'd4))+(A*8'd27)))));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule


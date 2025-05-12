
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (8'd14*H)+(((I*8'd6)+(8'd30*K))+(((E*8'd10)+(8'd12*F))+((((8'd4*A)+(D*8'd20))+(((8'd0*C)+(8'd8*B))+(8'd18*G)))+(8'd15*J))));
  wire [7:0] 
       total_weight = ((((E*8'd27)+((8'd18*D)+(8'd28*A)))+((F*8'd28)+(H*8'd1)))+((C*8'd27)+(8'd8*B)))+(((8'd6*G)+(8'd0*J))+((8'd5*K)+(8'd20*I)));
  wire [7:0] 
       total_volume = ((8'd4*D)+(((8'd0*E)+(((F*8'd24)+((C*8'd4)+(8'd27*B)))+(A*8'd27)))+(8'd20*H)))+((8'd5*K)+((8'd15*J)+((8'd12*I)+(G*8'd4))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


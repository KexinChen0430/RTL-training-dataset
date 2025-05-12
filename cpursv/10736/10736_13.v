
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (G*8'd18)+(((8'd30*K)+((8'd15*J)+(H*8'd14)))+((((C*8'd0)+((A*8'd4)+(B*8'd8)))+(I*8'd6))+((8'd10*E)+((8'd20*D)+(8'd12*F)))));
  wire [7:0] 
       total_weight = (((H*8'd1)+(8'd28*F))+(((J*8'd0)+(8'd20*I))+(K*8'd5)))+(((C*8'd27)+(8'd28*A))+(((8'd6*G)+(D*8'd18))+((8'd27*E)+(B*8'd8))));
  wire [7:0] 
       total_volume = ((((8'd15*J)+(8'd4*G))+(((8'd4*D)+(8'd27*A))+(((8'd4*C)+(B*8'd27))+((F*8'd24)+(8'd0*E)))))+((8'd12*I)+(K*8'd5)))+(8'd20*H);

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule


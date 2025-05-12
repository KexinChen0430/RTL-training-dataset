
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((H*8'd14)+(8'd15*J))+((((K*8'd30)+(8'd8*L))+(8'd16*M))+(((((8'd18*G)+(8'd4*A))+(((D*8'd20)+(B*8'd8))+(C*8'd0)))+(8'd6*I))+((F*8'd12)+(E*8'd10))));
  wire [7:0] 
       total_weight = (((8'd13*L)+((M*8'd8)+(8'd5*K)))+(((((D*8'd18)+(8'd27*E))+(8'd6*G))+((((C*8'd27)+(8'd28*A))+(8'd28*F))+(B*8'd8)))+((8'd1*H)+(J*8'd0))))+(I*8'd20);
  wire [7:0] 
       total_volume = ((I*8'd12)+((8'd15*J)+(8'd5*K)))+(((((((E*8'd0)+(B*8'd27))+(D*8'd4))+((H*8'd20)+(F*8'd24)))+((8'd27*A)+(C*8'd4)))+(G*8'd4))+((M*8'd9)+(L*8'd2)));

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule


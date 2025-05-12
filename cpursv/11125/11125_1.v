
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (8'd8*L)+((((8'd6*I)+(8'd30*K))+((8'd16*M)+(J*8'd15)))+((((B*8'd8)+(8'd20*D))+((C*8'd0)+(A*8'd4)))+((8'd12*F)+((8'd10*E)+((H*8'd14)+(G*8'd18))))));
  wire [7:0] 
       total_weight = ((((8'd13*L)+(8'd5*K))+(M*8'd8))+((8'd28*F)+(((((8'd27*E)+(D*8'd18))+(B*8'd8))+((8'd6*G)+((C*8'd27)+(8'd28*A))))+((J*8'd0)+(8'd1*H)))))+(8'd20*I);
  wire [7:0] 
       total_volume = ((8'd12*I)+(8'd20*H))+((((8'd4*G)+(E*8'd0))+(((D*8'd4)+(((8'd27*A)+((C*8'd4)+(8'd27*B)))+(F*8'd24)))+(8'd5*K)))+((J*8'd15)+((8'd2*L)+(M*8'd9))));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


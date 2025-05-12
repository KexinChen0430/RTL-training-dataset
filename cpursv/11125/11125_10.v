
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((H*8'd14)+((G*8'd18)+(E*8'd10)))+(J*8'd15))+((B*8'd8)+(((8'd20*D)+(8'd12*F))+((C*8'd0)+(8'd4*A)))))+(((I*8'd6)+(K*8'd30))+((8'd16*M)+(8'd8*L)));
  wire [7:0] 
       total_weight = (H*8'd1)+((((((D*8'd18)+((8'd28*A)+(E*8'd27)))+((8'd6*G)+(8'd28*F)))+((B*8'd8)+(C*8'd27)))+((J*8'd0)+(I*8'd20)))+(((L*8'd13)+(M*8'd8))+(K*8'd5)));
  wire [7:0] 
       total_volume = (((L*8'd2)+((J*8'd15)+(8'd9*M)))+(K*8'd5))+(((I*8'd12)+(8'd4*G))+(((((C*8'd4)+(B*8'd27))+(H*8'd20))+((8'd4*D)+(8'd27*A)))+((E*8'd0)+(F*8'd24))));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule


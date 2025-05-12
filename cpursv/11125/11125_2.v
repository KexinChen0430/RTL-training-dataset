
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd16*M)+(((((8'd0*C)+(D*8'd20))+(((G*8'd18)+(8'd14*H))+((8'd4*A)+(B*8'd8))))+(J*8'd15))+((E*8'd10)+(8'd12*F))))+(((8'd30*K)+(I*8'd6))+(L*8'd8));
  wire [7:0] 
       total_weight = (((H*8'd1)+(G*8'd6))+((8'd8*M)+((L*8'd13)+(K*8'd5))))+(((8'd0*J)+(8'd20*I))+((((8'd28*A)+(D*8'd18))+((B*8'd8)+(C*8'd27)))+((8'd27*E)+(8'd28*F))));
  wire [7:0] 
       total_volume = ((K*8'd5)+(H*8'd20))+((((D*8'd4)+(8'd0*E))+((((8'd27*B)+(8'd27*A))+((8'd24*F)+(8'd4*C)))+((8'd4*G)+(I*8'd12))))+((8'd9*M)+((8'd2*L)+(J*8'd15))));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


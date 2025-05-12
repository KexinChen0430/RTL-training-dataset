
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd30*K)+(8'd6*I))+((((J*8'd15)+(8'd16*M))+(L*8'd8))+(((8'd20*D)+(8'd12*F))+((((A*8'd4)+(C*8'd0))+(8'd8*B))+(((8'd14*H)+(8'd18*G))+(8'd10*E)))));
  wire [7:0] 
       total_weight = ((I*8'd20)+(K*8'd5))+((((H*8'd1)+(J*8'd0))+(((E*8'd27)+((8'd28*F)+(G*8'd6)))+((((8'd27*C)+(D*8'd18))+(A*8'd28))+(8'd8*B))))+((8'd13*L)+(M*8'd8)));
  wire [7:0] 
       total_volume = (((L*8'd2)+((K*8'd5)+(8'd9*M)))+((((8'd24*F)+(H*8'd20))+((8'd4*C)+(8'd4*D)))+(((8'd27*A)+(B*8'd27))+(8'd0*E))))+(((8'd4*G)+(I*8'd12))+(J*8'd15));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


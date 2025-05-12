
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd16*M)+(8'd30*K))+((((I*8'd6)+(H*8'd14))+(F*8'd12))+(((((B*8'd8)+((A*8'd4)+(D*8'd20)))+((E*8'd10)+(8'd0*C)))+(8'd18*G))+((8'd15*J)+(8'd8*L))));
  wire [7:0] 
       total_weight = ((((((((G*8'd6)+(D*8'd18))+((B*8'd8)+(8'd27*C)))+((8'd28*A)+(E*8'd27)))+(J*8'd0))+(8'd28*F))+(K*8'd5))+((L*8'd13)+(M*8'd8)))+((H*8'd1)+(I*8'd20));
  wire [7:0] 
       total_volume = (I*8'd12)+(((K*8'd5)+((8'd2*L)+(8'd9*M)))+((((8'd0*E)+(8'd24*F))+(8'd15*J))+(((8'd4*D)+((8'd4*C)+(A*8'd27)))+((B*8'd27)+((8'd4*G)+(H*8'd20))))));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule



module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((J*8'd15)+((K*8'd30)+(I*8'd6)))+((((8'd14*H)+(((8'd0*C)+(B*8'd8))+((8'd10*E)+(8'd4*A))))+((8'd12*F)+((D*8'd20)+(G*8'd18))))+((8'd8*L)+(8'd16*M)));
  wire [7:0] 
       total_weight = (((((I*8'd20)+(K*8'd5))+((((G*8'd6)+(8'd1*H))+((B*8'd8)+(C*8'd27)))+((8'd28*A)+(D*8'd18))))+((8'd27*E)+(8'd28*F)))+((M*8'd8)+(L*8'd13)))+(J*8'd0);
  wire [7:0] 
       total_volume = (((I*8'd12)+(8'd2*L))+((8'd9*M)+(K*8'd5)))+((((8'd20*H)+(8'd4*G))+(((8'd4*D)+(B*8'd27))+((C*8'd4)+(A*8'd27))))+(((E*8'd0)+(8'd24*F))+(J*8'd15)));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


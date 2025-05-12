
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((J*8'd15)+(((((8'd12*F)+(8'd10*E))+(G*8'd18))+((8'd20*D)+((C*8'd0)+(8'd4*A))))+(B*8'd8)))+(((8'd30*K)+(8'd8*L))+(8'd16*M)))+((I*8'd6)+(8'd14*H));
  wire [7:0] 
       total_weight = (((8'd13*L)+(8'd8*M))+(((C*8'd27)+(A*8'd28))+(((H*8'd1)+((8'd28*F)+(8'd6*G)))+(((8'd18*D)+(E*8'd27))+(B*8'd8)))))+(((K*8'd5)+(8'd20*I))+(J*8'd0));
  wire [7:0] 
       total_volume = ((8'd12*I)+((K*8'd5)+(8'd2*L)))+((M*8'd9)+(((((H*8'd20)+(8'd4*G))+((8'd27*A)+(8'd4*C)))+((8'd4*D)+(B*8'd27)))+((J*8'd15)+((F*8'd24)+(8'd0*E)))));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


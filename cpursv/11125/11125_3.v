
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((L*8'd8)+(8'd16*M))+((I*8'd6)+(8'd30*K)))+(((F*8'd12)+(8'd14*H))+(((A*8'd4)+(((8'd0*C)+(E*8'd10))+((8'd20*D)+(8'd8*B))))+((J*8'd15)+(8'd18*G))));
  wire [7:0] 
       total_weight = ((8'd20*I)+((M*8'd8)+(8'd13*L)))+((((8'd0*J)+(K*8'd5))+((((8'd28*A)+(8'd8*B))+(8'd18*D))+((H*8'd1)+(((E*8'd27)+(F*8'd28))+(C*8'd27)))))+(8'd6*G));
  wire [7:0] 
       total_volume = (((8'd4*G)+(F*8'd24))+(((I*8'd12)+(((8'd27*B)+((D*8'd4)+(C*8'd4)))+((8'd0*E)+(A*8'd27))))+((K*8'd5)+(8'd20*H))))+(((M*8'd9)+(J*8'd15))+(8'd2*L));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


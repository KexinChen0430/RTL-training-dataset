
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd30*K)+((((E*8'd10)+(8'd18*G))+((F*8'd12)+(H*8'd14)))+(((D*8'd20)+(8'd8*B))+((8'd4*A)+(C*8'd0)))))+((((8'd15*J)+(8'd8*L))+(M*8'd16))+(I*8'd6));
  wire [7:0] 
       total_weight = ((((M*8'd8)+(L*8'd13))+(J*8'd0))+((((H*8'd1)+(G*8'd6))+(E*8'd27))+((((8'd8*B)+((8'd28*A)+(8'd27*C)))+((8'd18*D)+(8'd28*F)))+(K*8'd5))))+(8'd20*I);
  wire [7:0] 
       total_volume = ((((((G*8'd4)+(E*8'd0))+((A*8'd27)+((8'd24*F)+(B*8'd27))))+((8'd4*D)+(8'd4*C)))+(K*8'd5))+(((L*8'd2)+(M*8'd9))+(8'd15*J)))+((H*8'd20)+(8'd12*I));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


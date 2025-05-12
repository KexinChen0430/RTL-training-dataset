
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((((M*8'd16)+((I*8'd6)+(8'd14*H)))+((((8'd12*F)+(8'd18*G))+((A*8'd4)+(8'd8*B)))+(((8'd0*C)+(E*8'd10))+(D*8'd20))))+((K*8'd30)+(J*8'd15)))+(8'd8*L))+(8'd14*P))+((N*8'd18)+(O*8'd18));
  wire [7:0] 
       total_weight = (((8'd12*P)+(O*8'd22))+((((8'd8*M)+(I*8'd20))+((((J*8'd0)+(8'd5*K))+((8'd1*H)+(((A*8'd28)+((8'd8*B)+(D*8'd18)))+(((8'd28*F)+(8'd27*C))+(8'd27*E)))))+(G*8'd6)))+(N*8'd14)))+(L*8'd13);
  wire [7:0] 
       total_volume = ((O*8'd19)+(N*8'd28))+((((P*8'd18)+(((((I*8'd12)+(H*8'd20))+(F*8'd24))+((((8'd4*G)+((8'd27*A)+(B*8'd27)))+((8'd4*C)+(D*8'd4)))+(E*8'd0)))+((L*8'd2)+(8'd5*K))))+(J*8'd15))+(8'd9*M));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule


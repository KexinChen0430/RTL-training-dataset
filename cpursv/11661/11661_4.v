
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd14*P)+(M*8'd16))+((((O*8'd18)+((((8'd15*J)+(K*8'd30))+(((8'd14*H)+(8'd10*E))+((((F*8'd12)+(8'd20*D))+((B*8'd8)+((C*8'd0)+(A*8'd4))))+(G*8'd18))))+(I*8'd6)))+(N*8'd18))+(8'd8*L));
  wire [7:0] 
       total_weight = ((((N*8'd14)+(8'd12*P))+(8'd22*O))+((((J*8'd0)+(L*8'd13))+(((I*8'd20)+((F*8'd28)+(E*8'd27)))+((((8'd6*G)+((B*8'd8)+(8'd28*A)))+(C*8'd27))+(D*8'd18))))+(8'd1*H)))+((K*8'd5)+(M*8'd8));
  wire [7:0] 
       total_volume = ((((8'd9*M)+(N*8'd28))+(8'd19*O))+((K*8'd5)+((((L*8'd2)+(8'd15*J))+(((H*8'd20)+(F*8'd24))+(I*8'd12)))+((((8'd0*E)+(C*8'd4))+((D*8'd4)+((8'd27*B)+(A*8'd27))))+(G*8'd4)))))+(P*8'd18);

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


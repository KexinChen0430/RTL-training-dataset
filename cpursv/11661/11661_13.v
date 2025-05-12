
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((P*8'd14)+(((8'd30*K)+(8'd14*H))+((((I*8'd6)+(8'd12*F))+((E*8'd10)+(G*8'd18)))+((((8'd8*B)+(8'd4*A))+(D*8'd20))+(8'd0*C)))))+((L*8'd8)+(8'd15*J)))+(((O*8'd18)+(N*8'd18))+(M*8'd16));
  wire [7:0] 
       total_weight = (((8'd14*N)+((8'd22*O)+(P*8'd12)))+((M*8'd8)+((((K*8'd5)+(H*8'd1))+(8'd0*J))+((I*8'd20)+(((((((C*8'd27)+(8'd8*B))+(A*8'd28))+(F*8'd28))+(8'd6*G))+(E*8'd27))+(D*8'd18))))))+(8'd13*L);
  wire [7:0] 
       total_volume = ((8'd18*P)+((L*8'd2)+(8'd9*M)))+((((N*8'd28)+(8'd19*O))+(I*8'd12))+((((8'd15*J)+(K*8'd5))+(((8'd4*G)+(((8'd27*B)+(8'd4*C))+((8'd27*A)+(E*8'd0))))+((8'd4*D)+(F*8'd24))))+(H*8'd20)));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule


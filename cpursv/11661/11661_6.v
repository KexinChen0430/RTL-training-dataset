
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((((8'd8*L)+(8'd15*J))+(8'd30*K))+((8'd12*F)+((8'd6*I)+(H*8'd14))))+((((((C*8'd0)+(8'd8*B))+(A*8'd4))+(G*8'd18))+(E*8'd10))+(D*8'd20)))+((O*8'd18)+(P*8'd14)))+((8'd16*M)+(8'd18*N));
  wire [7:0] 
       total_weight = (((P*8'd12)+(8'd22*O))+(((((G*8'd6)+(((8'd27*C)+(A*8'd28))+((8'd8*B)+((E*8'd27)+(D*8'd18)))))+((H*8'd1)+(8'd28*F)))+(((K*8'd5)+(8'd0*J))+(I*8'd20)))+((8'd13*L)+(8'd14*N))))+(8'd8*M);
  wire [7:0] 
       total_volume = (((O*8'd19)+(8'd18*P))+((8'd9*M)+(8'd28*N)))+((8'd15*J)+((((K*8'd5)+(L*8'd2))+((8'd4*G)+((D*8'd4)+((((8'd27*(B+A))+(F*8'd24))+(E*8'd0))+(C*8'd4)))))+((8'd20*H)+(8'd12*I))));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule


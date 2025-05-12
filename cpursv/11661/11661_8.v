
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((O+N)*8'd18)+(P*8'd14))+((K*8'd30)+((M*8'd16)+(L*8'd8))))+(((8'd15*J)+((((8'd8*B)+(A*8'd4))+(8'd20*D))+((C*8'd0)+((E*8'd10)+(F*8'd12)))))+(((H*8'd14)+(I*8'd6))+(8'd18*G)));
  wire [7:0] 
       total_weight = ((((P*8'd12)+(8'd14*N))+(O*8'd22))+((((8'd8*M)+(8'd0*J))+(I*8'd20))+(((K*8'd5)+(((8'd6*G)+((8'd8*B)+(C*8'd27)))+(((8'd27*E)+(D*8'd18))+(A*8'd28))))+((8'd28*F)+(H*8'd1)))))+(8'd13*L);
  wire [7:0] 
       total_volume = (((P*8'd18)+(O*8'd19))+(((K*8'd5)+(8'd9*M))+(8'd28*N)))+(((8'd2*L)+(((8'd4*G)+((E*8'd0)+(((8'd27*A)+((C*8'd4)+(B*8'd27)))+(D*8'd4))))+(((H*8'd20)+(8'd24*F))+(I*8'd12))))+(8'd15*J));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


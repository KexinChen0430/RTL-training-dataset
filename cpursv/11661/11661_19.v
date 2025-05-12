
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (8'd18*O)+(((8'd14*P)+((((K*8'd30)+((8'd8*L)+(8'd16*M)))+((8'd6*I)+(8'd15*J)))+(((H*8'd14)+(G*8'd18))+(((8'd12*F)+((E*8'd10)+(8'd0*C)))+(((D*8'd20)+(B*8'd8))+(8'd4*A))))))+(8'd18*N));
  wire [7:0] 
       total_weight = ((((O*8'd22)+(P*8'd12))+(M*8'd8))+(((N*8'd14)+(((((8'd28*F)+(8'd1*H))+(((8'd27*C)+(8'd18*D))+(8'd27*E)))+((B*8'd8)+(A*8'd28)))+((8'd0*J)+(8'd6*G))))+(I*8'd20)))+((8'd13*L)+(8'd5*K));
  wire [7:0] 
       total_volume = ((8'd19*O)+(((8'd18*P)+(8'd5*K))+(((((8'd2*L)+(8'd15*J))+((G*8'd4)+((H*8'd20)+(I*8'd12))))+((((8'd0*E)+(C*8'd4))+(8'd24*F))+(((B*8'd27)+(D*8'd4))+(8'd27*A))))+(M*8'd9))))+(N*8'd28);

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule


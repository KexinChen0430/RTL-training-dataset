
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((P*8'd14)+(8'd18*N))+(((8'd18*O)+(((8'd16*M)+(8'd15*J))+(L*8'd8)))+((((8'd30*K)+(I*8'd6))+(((D*8'd20)+(E*8'd10))+(((8'd0*C)+((A*8'd4)+(8'd8*B)))+((8'd18*G)+(8'd12*F)))))+(H*8'd14)));
  wire [7:0] 
       total_weight = ((O*8'd22)+(((P*8'd12)+(J*8'd0))+((((L*8'd13)+((8'd27*E)+((((8'd27*C)+(8'd8*B))+(A*8'd28))+((8'd28*F)+(D*8'd18)))))+((G*8'd6)+((8'd20*I)+(8'd1*H))))+(K*8'd5))))+((M*8'd8)+(8'd14*N));
  wire [7:0] 
       total_volume = ((8'd18*P)+((8'd9*M)+((8'd19*O)+(N*8'd28))))+((((L*8'd2)+(K*8'd5))+(8'd12*I))+((((8'd15*J)+(((8'd4*C)+(B*8'd27))+((8'd0*E)+(A*8'd27))))+((8'd4*D)+(8'd24*F)))+((G*8'd4)+(8'd20*H))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


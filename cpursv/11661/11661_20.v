
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((8'd16*M)+(8'd18*O))+(P*8'd14))+(L*8'd8))+(((N*8'd18)+((((G*8'd18)+(8'd6*I))+((8'd10*E)+(8'd12*F)))+(((8'd8*B)+(8'd0*C))+((8'd4*A)+(D*8'd20)))))+(((K*8'd30)+(8'd15*J))+(8'd14*H)));
  wire [7:0] 
       total_weight = (((O*8'd22)+(8'd12*P))+((((8'd8*M)+(8'd14*N))+(((8'd1*H)+(8'd20*I))+(8'd0*J)))+(((((D*8'd18)+(8'd6*G))+((C*8'd27)+(8'd8*B)))+((8'd27*E)+(A*8'd28)))+(8'd28*F))))+((K*8'd5)+(8'd13*L));
  wire [7:0] 
       total_volume = ((M*8'd9)+(8'd28*N))+((((8'd18*P)+(8'd19*O))+(((8'd15*J)+(8'd2*L))+((((I*8'd12)+(8'd4*G))+((((8'd24*F)+(B*8'd27))+((A*8'd27)+(C*8'd4)))+(8'd4*D)))+((8'd20*H)+(E*8'd0)))))+(K*8'd5));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


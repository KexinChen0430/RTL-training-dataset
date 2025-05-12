
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd14*P)+(M*8'd16))+((((O*8'd18)+(N*8'd18))+((J*8'd15)+(((((8'd14*H)+(F*8'd12))+(8'd6*I))+((G*8'd18)+(D*8'd20)))+(((B*8'd8)+(E*8'd10))+((A*8'd4)+(8'd0*C))))))+((8'd30*K)+(L*8'd8)));
  wire [7:0] 
       total_weight = ((8'd22*O)+(((L*8'd13)+(N*8'd14))+(((((I*8'd20)+(J*8'd0))+(8'd5*K))+(((B*8'd8)+((C*8'd27)+(A*8'd28)))+((D*8'd18)+(8'd28*F))))+((8'd27*E)+((H*8'd1)+(8'd6*G))))))+((8'd8*M)+(P*8'd12));
  wire [7:0] 
       total_volume = ((((8'd28*N)+(8'd19*O))+(P*8'd18))+((8'd9*M)+(8'd5*K)))+(((8'd2*L)+((H*8'd20)+(G*8'd4)))+((((8'd12*I)+(((C*8'd4)+(8'd27*B))+(8'd27*A)))+(((F*8'd24)+(8'd0*E))+(D*8'd4)))+(J*8'd15)));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


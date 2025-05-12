
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((R*9'd7)+(9'd14*P))+(9'd7*Q))+((9'd8*L)+((N*9'd18)+(O*9'd18))))+((((9'd16*M)+(9'd30*K))+((((J*9'd15)+((((D*9'd20)+(C*9'd0))+(9'd10*E))+((B*9'd8)+(9'd4*A))))+(F*9'd12))+(I*9'd6)))+((G*9'd18)+(9'd14*H)));
  wire [8:0] 
       total_weight = (((((L*9'd13)+(9'd8*M))+((I*9'd20)+(9'd1*H)))+(((((G*9'd6)+(D*9'd18))+(9'd28*F))+((9'd27*E)+(((A*9'd28)+(C*9'd27))+(B*9'd8))))+((K*9'd5)+(J*9'd0))))+((N*9'd14)+(P*9'd12)))+(((9'd22*O)+(9'd23*Q))+(9'd26*R));
  wire [8:0] 
       total_volume = (((9'd12*R)+(9'd30*Q))+(9'd28*N))+((((((9'd2*L)+(M*9'd9))+(K*9'd5))+((F*9'd24)+((((G*9'd4)+(9'd0*E))+(((C*9'd4)+(9'd27*A))+(9'd4*D)))+(9'd27*B))))+(((H*9'd20)+(I*9'd12))+(J*9'd15)))+((9'd18*P)+(9'd19*O)));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule



module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd29*S)+(9'd23*T))+(((U*9'd24)+((Q*9'd7)+(P*9'd14)))+(((O*9'd18)+(9'd7*R))+(((((L*9'd8)+(J*9'd15))+(((I*9'd6)+(9'd14*H))+(F*9'd12)))+((((A*9'd4)+(C*9'd0))+((E*9'd10)+(B*9'd8)))+((G*9'd18)+(D*9'd20))))+((9'd30*K)+((M*9'd16)+(9'd18*N)))))))+(9'd3*V);
  wire [8:0] 
       total_weight = ((9'd22*T)+((9'd15*V)+(U*9'd26)))+(((((S*9'd1)+(R*9'd26))+(9'd23*Q))+((((((9'd20*I)+(G*9'd6))+(F*9'd28))+(((9'd27*E)+(H*9'd1))+(((9'd18*D)+(9'd27*C))+((9'd28*A)+(B*9'd8)))))+((L*9'd13)+(M*9'd8)))+((J*9'd0)+(9'd5*K))))+(((9'd12*P)+(9'd22*O))+(9'd14*N)));
  wire [8:0] 
       total_volume = ((U*9'd18)+((9'd16*V)+(9'd28*S)))+((((9'd12*R)+(T*9'd13))+((((Q*9'd30)+(9'd19*O))+((((9'd5*K)+((((9'd27*A)+(9'd27*B))+((D+C)*9'd4))+(F*9'd24)))+((9'd0*E)+(9'd4*G)))+(((H*9'd20)+(9'd12*I))+(J*9'd15))))+(((9'd9*M)+(L*9'd2))+(9'd28*N))))+(9'd18*P));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


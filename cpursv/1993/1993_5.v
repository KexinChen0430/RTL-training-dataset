
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((S*9'd29)+(R*9'd7))+(T*9'd23))+((9'd18*O)+(9'd14*P)))+((((N*9'd18)+((9'd30*K)+(9'd8*L)))+((M*9'd16)+(((9'd6*I)+(((H*9'd14)+((F*9'd12)+(9'd18*G)))+(((9'd8*B)+(E*9'd10))+((9'd4*A)+((D*9'd20)+(9'd0*C))))))+(J*9'd15))))+(Q*9'd7));
  wire [8:0] 
       total_weight = ((9'd23*Q)+(R*9'd26))+(((9'd1*S)+(9'd22*T))+((P*9'd12)+((((9'd8*M)+(N*9'd14))+(9'd22*O))+((((((G*9'd6)+(9'd0*J))+(9'd20*I))+(F*9'd28))+(((9'd1*H)+((((9'd27*C)+(E*9'd27))+(9'd8*B))+(A*9'd28)))+(9'd18*D)))+((L*9'd13)+(9'd5*K))))));
  wire [8:0] 
       total_volume = (((9'd13*T)+(9'd12*R))+(((((9'd18*P)+(9'd9*M))+(((9'd5*K)+(9'd28*N))+(((((9'd4*G)+(9'd12*I))+(J*9'd15))+(((H*9'd20)+((9'd27*(B+A))+(C*9'd4)))+((E*9'd0)+(D*9'd4))))+(9'd24*F))))+(L*9'd2))+(9'd19*O)))+((9'd30*Q)+(S*9'd28));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


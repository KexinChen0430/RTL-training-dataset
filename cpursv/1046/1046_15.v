
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd18*W)+(9'd5*X))+(9'd3*V))+((((R*9'd7)+(Q*9'd7))+((9'd14*P)+(((((9'd16*M)+(9'd30*K))+(((F*9'd12)+((D*9'd20)+(9'd18*G)))+(((C*9'd0)+((A*9'd4)+(9'd8*B)))+(9'd10*E))))+((H*9'd14)+((9'd6*I)+(9'd15*J))))+(((9'd18*N)+(O*9'd18))+(9'd8*L)))))+((9'd24*U)+(S*9'd29))))+(T*9'd23);
  wire [8:0] 
       total_weight = ((X*9'd21)+(((9'd0*W)+(T*9'd22))+(9'd15*V)))+((((S*9'd1)+(9'd26*U))+((((9'd23*Q)+(9'd26*R))+(((M*9'd8)+((((G*9'd6)+(F*9'd28))+((((I*9'd20)+(H*9'd1))+((((9'd8*B)+(D*9'd18))+(9'd27*C))+(9'd28*A)))+(9'd27*E)))+((9'd0*J)+(L*9'd13))))+((9'd5*K)+(N*9'd14))))+(9'd22*O)))+(P*9'd12));
  wire [8:0] 
       total_volume = ((X*9'd3)+((((S*9'd28)+(((N*9'd28)+(((9'd5*K)+((9'd4*G)+(9'd20*H)))+(((I*9'd12)+(((A*9'd27)+(B*9'd27))+((C*9'd4)+(E*9'd0))))+((F*9'd24)+(9'd4*D)))))+(((L*9'd2)+(9'd15*J))+(M*9'd9))))+(((Q*9'd30)+(9'd19*O))+(9'd18*P)))+((U*9'd18)+(9'd12*R))))+(((W*9'd26)+(9'd13*T))+(9'd16*V));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


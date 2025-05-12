
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd18*W)+(V*9'd3))+(9'd5*X))+((U*9'd24)+(T*9'd23)))+((9'd7*Q)+(((9'd14*P)+((((M*9'd16)+(O*9'd18))+((((I*9'd6)+(L*9'd8))+((G*9'd18)+(J*9'd15)))+(((9'd20*D)+(((((A*9'd4)+(C*9'd0))+(9'd8*B))+(F*9'd12))+(9'd10*E)))+(H*9'd14))))+((K*9'd30)+(N*9'd18))))+((S*9'd29)+(9'd7*R))));
  wire [8:0] 
       total_weight = (((((9'd1*S)+(9'd26*U))+((O*9'd22)+((Q*9'd23)+(9'd26*R))))+(((9'd12*P)+(9'd8*M))+((((((K*9'd5)+(L*9'd13))+(F*9'd28))+(((9'd1*H)+(9'd6*G))+((9'd18*D)+((((A*9'd28)+(E*9'd27))+(9'd8*B))+(9'd27*C)))))+((J*9'd0)+(I*9'd20)))+(9'd14*N))))+(9'd22*T))+((V*9'd15)+((9'd21*X)+(9'd0*W)));
  wire [8:0] 
       total_volume = (((9'd3*X)+(9'd26*W))+(9'd16*V))+(((((9'd13*T)+(U*9'd18))+(9'd12*R))+(9'd30*Q))+((S*9'd28)+((((9'd28*N)+(9'd18*P))+(9'd9*M))+(((9'd19*O)+(((L*9'd2)+(J*9'd15))+(K*9'd5)))+((((H*9'd20)+(((E*9'd0)+(C*9'd4))+(F*9'd24)))+(((9'd27*B)+(D*9'd4))+(9'd27*A)))+((G*9'd4)+(9'd12*I)))))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule


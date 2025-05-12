
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((U*9'd24)+(V*9'd3))+(R*9'd7))+((((9'd29*S)+(T*9'd23))+((N*9'd18)+(9'd18*O)))+((((9'd7*Q)+(P*9'd14))+(((9'd16*M)+((((9'd15*J)+(((C*9'd0)+(9'd8*B))+(A*9'd4)))+((D*9'd20)+((E*9'd10)+(9'd12*F))))+((9'd18*G)+(9'd14*H))))+(I*9'd6)))+((9'd30*K)+(L*9'd8))));
  wire [8:0] 
       total_weight = (((S*9'd1)+((U*9'd26)+(9'd15*V)))+((T*9'd22)+(Q*9'd23)))+(((9'd22*O)+(P*9'd12))+((R*9'd26)+((9'd8*M)+(((K*9'd5)+(9'd14*N))+(((L*9'd13)+((9'd1*H)+(G*9'd6)))+((((9'd0*J)+(I*9'd20))+((9'd18*D)+((9'd8*B)+(A*9'd28))))+(((C*9'd27)+(F*9'd28))+(9'd27*E))))))));
  wire [8:0] 
       total_volume = ((((V*9'd16)+(U*9'd18))+(T*9'd13))+(((9'd28*S)+(9'd18*P))+(R*9'd12)))+((Q*9'd30)+(((L*9'd2)+((9'd28*N)+(9'd19*O)))+((M*9'd9)+((((G*9'd4)+(I*9'd12))+(((9'd24*F)+(((9'd4*D)+(C*9'd4))+((9'd27*B)+(A*9'd27))))+((H*9'd20)+(9'd0*E))))+((9'd15*J)+(K*9'd5))))));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule


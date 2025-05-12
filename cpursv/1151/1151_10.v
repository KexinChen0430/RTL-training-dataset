
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd24*U)+(V*9'd3))+(((9'd8*L)+(O*9'd18))+((((J*9'd15)+(9'd30*K))+((((I*9'd6)+(9'd14*H))+((F*9'd12)+(9'd18*G)))+(((9'd4*A)+(9'd8*B))+(((E*9'd10)+(9'd0*C))+(D*9'd20)))))+((M*9'd16)+(N*9'd18)))))+(((R*9'd7)+(P*9'd14))+(9'd7*Q)))+((T*9'd23)+(9'd29*S));
  wire [8:0] 
       total_weight = ((((U*9'd26)+(V*9'd15))+(S*9'd1))+(9'd22*T))+((((9'd12*P)+((9'd23*Q)+(R*9'd26)))+(((((9'd13*L)+((9'd28*F)+(G*9'd6)))+((((9'd20*I)+(H*9'd1))+(((E*9'd27)+(9'd8*B))+(9'd18*D)))+((C*9'd27)+(A*9'd28))))+((9'd0*J)+(9'd5*K)))+((9'd22*O)+(N*9'd14))))+(M*9'd8));
  wire [8:0] 
       total_volume = ((V*9'd16)+(T*9'd13))+(((((9'd28*S)+((9'd9*M)+((9'd28*N)+(((9'd5*K)+(L*9'd2))+(((((9'd20*H)+(9'd12*I))+(J*9'd15))+(((F*9'd24)+(G*9'd4))+(E*9'd0)))+((9'd27*A)+(((C*9'd4)+(9'd27*B))+(9'd4*D))))))))+(9'd19*O))+(((R*9'd12)+(9'd30*Q))+(9'd18*P)))+(U*9'd18));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


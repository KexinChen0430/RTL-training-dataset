
module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd3*V)+((9'd7*R)+(9'd14*P)))+(((((9'd18*O)+(9'd18*N))+((M*9'd16)+(9'd8*L)))+(((((C*9'd0)+(9'd12*F))+((D*9'd20)+((B*9'd8)+(A*9'd4))))+((9'd10*E)+((G*9'd18)+(H*9'd14))))+(((J*9'd15)+(9'd30*K))+(9'd6*I))))+(9'd7*Q)))+(((9'd23*T)+(U*9'd24))+(S*9'd29));
  wire [8:0] 
       total_weight = ((9'd26*U)+((9'd22*T)+((((Q*9'd23)+(9'd26*R))+(((P*9'd12)+((9'd8*M)+(K*9'd5)))+((L*9'd13)+((((((9'd28*F)+(C*9'd27))+(E*9'd27))+((B*9'd8)+((A*9'd28)+(D*9'd18))))+((H*9'd1)+(9'd6*G)))+((J*9'd0)+(9'd20*I))))))+((O*9'd22)+(N*9'd14)))))+((V*9'd15)+(S*9'd1));
  wire [8:0] 
       total_volume = (T*9'd13)+((((U*9'd18)+(9'd16*V))+((9'd12*R)+(9'd28*S)))+((((((9'd19*O)+(9'd28*N))+(L*9'd2))+(9'd9*M))+((((K*9'd5)+(H*9'd20))+((((C*9'd4)+(D*9'd4))+((9'd27*A)+(B*9'd27)))+(((F*9'd24)+(G*9'd4))+(E*9'd0))))+((I*9'd12)+(J*9'd15))))+((P*9'd18)+(Q*9'd30))));

  assign valid = (total_volume <= max_volume) && 
                 ((total_weight <= max_weight) && 
(total_value >= min_value));
endmodule



module var22_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((T*9'd23)+(V*9'd3))+((R*9'd7)+(S*9'd29)))+(((((P*9'd14)+(9'd7*Q))+((9'd16*M)+(O*9'd18)))+((((N*9'd18)+(L*9'd8))+(K*9'd30))+(((((F*9'd12)+((E*9'd10)+(C*9'd0)))+((9'd20*D)+((B*9'd8)+(A*9'd4))))+((J*9'd15)+(I*9'd6)))+((H*9'd14)+(G*9'd18)))))+(U*9'd24));
  wire [8:0] 
       total_weight = ((((((9'd14*N)+((L*9'd13)+(M*9'd8)))+((((J*9'd0)+(K*9'd5))+((((9'd20*I)+(H*9'd1))+((9'd18*D)+(E*9'd27)))+((((F*9'd28)+(9'd6*G))+(A*9'd28))+((9'd27*C)+(B*9'd8)))))+(9'd22*O)))+((9'd12*P)+(9'd23*Q)))+(R*9'd26))+(S*9'd1))+(((T*9'd22)+(U*9'd26))+(V*9'd15));
  wire [8:0] 
       total_volume = ((9'd16*V)+(((P*9'd18)+(S*9'd28))+(((Q*9'd30)+(O*9'd19))+((9'd2*L)+((((J*9'd15)+(K*9'd5))+((M*9'd9)+(((9'd20*H)+(9'd12*I))+(((F*9'd24)+(((9'd0*E)+(9'd4*C))+(9'd27*(A+B))))+((G+D)*9'd4)))))+(N*9'd28))))))+(((T*9'd13)+(9'd18*U))+(R*9'd12));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule


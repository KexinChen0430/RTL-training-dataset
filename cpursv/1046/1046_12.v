
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((V*9'd3)+((9'd18*W)+(X*9'd5)))+((((Q*9'd7)+(((O*9'd18)+(9'd14*P))+(M*9'd16)))+((((K*9'd30)+(9'd18*N))+(((L*9'd8)+((C*9'd0)+((((E*9'd10)+(B*9'd8))+(9'd20*D))+(9'd4*A))))+(((9'd14*H)+(9'd18*G))+(9'd12*F))))+((9'd15*J)+(9'd6*I))))+(9'd7*R)))+(((9'd24*U)+(T*9'd23))+(S*9'd29));
  wire [8:0] 
       total_weight = (((W*9'd0)+(9'd21*X))+(((R*9'd26)+(9'd23*Q))+((((((9'd13*L)+(O*9'd22))+(9'd8*M))+(((9'd5*K)+((((9'd27*E)+((9'd28*F)+(G*9'd6)))+(((B*9'd8)+(9'd18*D))+(C*9'd27)))+(9'd28*A)))+(((J*9'd0)+(9'd1*H))+(I*9'd20))))+((9'd12*P)+(9'd14*N)))+(T*9'd22))))+(((S*9'd1)+(9'd26*U))+(V*9'd15));
  wire [8:0] 
       total_volume = ((X*9'd3)+((((V*9'd16)+(W*9'd26))+((Q*9'd30)+(R*9'd12)))+(((9'd13*T)+(S*9'd28))+(((9'd18*P)+((N*9'd28)+(9'd19*O)))+(((9'd9*M)+((9'd15*J)+(I*9'd12)))+((((9'd2*L)+((((E*9'd0)+((9'd4*G)+(9'd24*F)))+((A*9'd27)+(9'd4*C)))+((9'd27*B)+(D*9'd4))))+(9'd20*H))+(9'd5*K)))))))+(U*9'd18);

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule


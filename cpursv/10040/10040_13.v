
module var25_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((X*9'd5)+(9'd0*Y))+(((9'd7*R)+(U*9'd24))+(9'd23*T)))+((9'd29*S)+(((P*9'd14)+(((9'd7*Q)+((9'd30*K)+(9'd8*L)))+(((M*9'd16)+(((((J*9'd15)+(I*9'd6))+(9'd12*F))+((9'd0*C)+(((9'd8*B)+((9'd4*A)+(D*9'd20)))+(9'd10*E))))+(G*9'd18)))+(H*9'd14))))+((O+N)*9'd18))))+((W*9'd18)+(9'd3*V));
  wire [8:0] 
       total_weight = ((((9'd0*W)+(T*9'd22))+((((((M*9'd8)+((((9'd28*F)+(G*9'd6))+(((9'd20*I)+(D*9'd18))+((((C*9'd27)+(9'd27*E))+(9'd8*B))+(9'd28*A))))+(9'd1*H)))+(((K*9'd5)+(J*9'd0))+(9'd13*L)))+((9'd12*P)+(9'd14*N)))+((9'd26*R)+(9'd22*O)))+(Q*9'd23)))+((U*9'd26)+(9'd1*S)))+((9'd15*V)+((Y*9'd10)+(X*9'd21)));
  wire [8:0] 
       total_volume = ((9'd3*X)+((((W*9'd26)+(T*9'd13))+((9'd30*Q)+(((9'd28*S)+((9'd28*N)+(9'd9*M)))+((((P*9'd18)+(9'd19*O))+(K*9'd5))+(((((9'd20*H)+(J*9'd15))+((E*9'd0)+(9'd4*D)))+((((9'd4*G)+(9'd24*F))+(9'd27*A))+((9'd27*B)+(C*9'd4))))+((I*9'd12)+(L*9'd2)))))))+((9'd12*R)+(U*9'd18))))+((Y*9'd11)+(V*9'd16));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


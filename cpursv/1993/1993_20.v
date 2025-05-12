
module var20_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((9'd29*S)+(((T*9'd23)+((N*9'd18)+(((M*9'd16)+(L*9'd8))+((9'd18*O)+((((9'd6*I)+(K*9'd30))+(((J*9'd15)+(F*9'd12))+(((G*9'd18)+((9'd0*C)+(9'd10*E)))+(((A*9'd4)+(D*9'd20))+(9'd8*B)))))+(H*9'd14))))))+(P*9'd14)))+((9'd7*R)+(Q*9'd7));
  wire [8:0] 
       total_weight = (((Q*9'd23)+((T*9'd22)+(S*9'd1)))+((R*9'd26)+(O*9'd22)))+(((9'd12*P)+((9'd8*M)+(9'd13*L)))+((9'd14*N)+(((K*9'd5)+(((((I*9'd20)+(((9'd18*D)+(F*9'd28))+(E*9'd27)))+((9'd28*A)+((9'd8*B)+(9'd27*C))))+(9'd6*G))+(J*9'd0)))+(H*9'd1))));
  wire [8:0] 
       total_volume = (((T*9'd13)+(S*9'd28))+(((P*9'd18)+(9'd12*R))+((9'd19*O)+(((9'd28*N)+(L*9'd2))+((((9'd20*H)+(K*9'd5))+((((I*9'd12)+(F*9'd24))+((((E*9'd0)+(C*9'd4))+(9'd27*B))+(A*9'd27)))+((D*9'd4)+(9'd4*G))))+((J*9'd15)+(9'd9*M)))))))+(9'd30*Q);

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule


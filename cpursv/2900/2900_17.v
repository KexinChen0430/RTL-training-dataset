
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd7*Q)+(R*9'd7))+((9'd18*N)+((P*9'd14)+(O*9'd18))))+(((((M*9'd16)+(9'd8*L))+((9'd14*H)+(I*9'd6)))+(((9'd18*G)+(((F*9'd12)+(9'd10*E))+(((A*9'd4)+(C*9'd0))+(B*9'd8))))+(9'd20*D)))+((K*9'd30)+(J*9'd15)));
  wire [8:0] 
       total_weight = ((Q*9'd23)+(((9'd26*R)+(((N*9'd14)+((((I*9'd20)+(J*9'd0))+((((9'd28*A)+(B*9'd8))+(C*9'd27))+((9'd28*F)+(D*9'd18))))+((9'd27*E)+((G*9'd6)+(H*9'd1)))))+((9'd5*K)+(L*9'd13))))+(M*9'd8)))+((P*9'd12)+(9'd22*O));
  wire [8:0] 
       total_volume = (((R*9'd12)+((M*9'd9)+((J*9'd15)+(((((H*9'd20)+(9'd4*G))+(9'd12*I))+(((E*9'd0)+(9'd24*F))+((((C*9'd4)+(9'd4*D))+(9'd27*B))+(A*9'd27))))+((9'd5*K)+(9'd2*L))))))+((N*9'd28)+(O*9'd19)))+((9'd18*P)+(9'd30*Q));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule


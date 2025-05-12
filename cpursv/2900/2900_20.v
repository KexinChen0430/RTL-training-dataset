
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((((9'd7*R)+(P*9'd14))+(Q*9'd7))+(((L*9'd8)+(N*9'd18))+((((((F*9'd12)+(9'd18*G))+(((A*9'd4)+(E*9'd10))+(9'd8*B)))+((C*9'd0)+(9'd20*D)))+((9'd30*K)+(J*9'd15)))+((I*9'd6)+(9'd14*H)))))+((M*9'd16)+(9'd18*O));
  wire [8:0] 
       total_weight = ((9'd26*R)+((9'd22*O)+(((9'd8*M)+(9'd13*L))+(((9'd5*K)+(J*9'd0))+((G*9'd6)+(((I*9'd20)+(H*9'd1))+((((D*9'd18)+(9'd28*F))+(9'd27*C))+((9'd27*E)+((A*9'd28)+(9'd8*B))))))))))+((9'd14*N)+((9'd23*Q)+(P*9'd12)));
  wire [8:0] 
       total_volume = ((((9'd12*R)+(Q*9'd30))+(9'd18*P))+((9'd9*M)+(9'd2*L)))+(((((9'd20*H)+(((C*9'd4)+((E*9'd0)+(F*9'd24)))+((9'd27*B)+((D*9'd4)+(A*9'd27)))))+((I*9'd12)+(G*9'd4)))+((9'd5*K)+(J*9'd15)))+((O*9'd19)+(9'd28*N)));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


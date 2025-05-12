
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((R*9'd7)+((((N*9'd18)+(9'd8*L))+(((9'd16*M)+(((H*9'd14)+(9'd6*I))+(9'd15*J)))+((((A*9'd4)+((D*9'd20)+(9'd8*B)))+((9'd10*E)+(9'd0*C)))+((F*9'd12)+(G*9'd18)))))+(K*9'd30)))+(((9'd14*P)+(Q*9'd7))+(9'd18*O));
  wire [8:0] 
       total_weight = (((9'd23*Q)+(R*9'd26))+(((L*9'd13)+(9'd5*K))+(((((H*9'd1)+((((C*9'd27)+(F*9'd28))+(9'd28*A))+((9'd8*B)+(9'd18*D))))+(E*9'd27))+(((9'd6*G)+(9'd20*I))+(9'd0*J)))+(9'd14*N))))+(((9'd22*O)+(P*9'd12))+(9'd8*M));
  wire [8:0] 
       total_volume = ((O*9'd19)+(9'd18*P))+((((9'd12*R)+(9'd2*L))+(((9'd28*N)+(9'd9*M))+(((((H*9'd20)+(9'd15*J))+(9'd5*K))+((((9'd4*G)+((9'd4*D)+(9'd27*A)))+((C*9'd4)+(9'd27*B)))+((9'd0*E)+(F*9'd24))))+(9'd12*I))))+(Q*9'd30));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule


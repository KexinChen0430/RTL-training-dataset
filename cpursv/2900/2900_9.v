
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((Q*9'd7)+(((((9'd6*I)+((9'd15*J)+(9'd30*K)))+(G*9'd18))+(((H*9'd14)+(E*9'd10))+((((A*9'd4)+(9'd20*D))+((9'd8*B)+(9'd0*C)))+(F*9'd12))))+((9'd8*L)+((N*9'd18)+(9'd16*M)))))+(9'd18*O))+((P*9'd14)+(R*9'd7));
  wire [8:0] 
       total_weight = ((((9'd23*Q)+(R*9'd26))+(9'd8*M))+((((K*9'd5)+(9'd14*N))+((I*9'd20)+(9'd13*L)))+(((J*9'd0)+(9'd6*G))+(((F*9'd28)+(E*9'd27))+(((H*9'd1)+(9'd27*C))+((A*9'd28)+((9'd18*D)+(9'd8*B))))))))+((9'd12*P)+(9'd22*O));
  wire [8:0] 
       total_volume = ((9'd12*R)+((Q*9'd30)+(9'd19*O)))+(((N*9'd28)+((((9'd4*G)+((((9'd20*H)+(9'd0*E))+((C*9'd4)+(9'd4*D)))+(((B*9'd27)+(9'd27*A))+(9'd24*F))))+((K*9'd5)+(L*9'd2)))+((9'd15*J)+(9'd12*I))))+((9'd9*M)+(9'd18*P)));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule


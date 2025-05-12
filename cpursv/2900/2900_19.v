
module var18_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R;
  output valid;
  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = ((O*9'd18)+(9'd14*P))+((((9'd7*R)+(9'd7*Q))+(9'd18*N))+(((9'd16*M)+(((H*9'd14)+(J*9'd15))+(((G*9'd18)+(((9'd20*D)+(E*9'd10))+(9'd12*F)))+(((9'd0*C)+(A*9'd4))+(B*9'd8)))))+((9'd6*I)+((K*9'd30)+(L*9'd8)))));
  wire [8:0] 
       total_weight = (((R*9'd26)+(9'd23*Q))+(O*9'd22))+(((9'd12*P)+((((I*9'd20)+((K*9'd5)+(9'd0*J)))+((G*9'd6)+(9'd28*F)))+(((H*9'd1)+((A*9'd28)+((9'd27*C)+(B*9'd8))))+((D*9'd18)+(9'd27*E)))))+(((9'd13*L)+(9'd8*M))+(9'd14*N)));
  wire [8:0] 
       total_volume = ((((Q*9'd30)+(9'd12*R))+(9'd18*P))+((((9'd9*M)+(L*9'd2))+(((H*9'd20)+(J*9'd15))+(K*9'd5)))+((9'd12*I)+((((9'd27*B)+((D*9'd4)+(9'd27*A)))+((F*9'd24)+(9'd4*C)))+((G*9'd4)+(9'd0*E))))))+((9'd28*N)+(9'd19*O));

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule


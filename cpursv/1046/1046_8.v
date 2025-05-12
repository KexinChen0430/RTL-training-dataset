
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((9'd18*W)+(X*9'd5))+((((T*9'd23)+(9'd3*V))+(((9'd18*O)+(9'd14*P))+(((9'd7*Q)+((9'd18*N)+(9'd16*M)))+(((((I*9'd6)+(9'd30*K))+(9'd8*L))+((((9'd14*H)+(F*9'd12))+((9'd4*A)+(9'd8*B)))+(((D*9'd20)+(E*9'd10))+(C*9'd0))))+((9'd15*J)+(9'd18*G))))))+((9'd7*R)+(9'd29*S))))+(U*9'd24);
  wire [8:0] 
       total_weight = (((9'd1*S)+(R*9'd26))+((((9'd22*T)+(U*9'd26))+(Q*9'd23))+(((P*9'd12)+(((9'd8*M)+(((((I*9'd20)+(G*9'd6))+(((9'd18*D)+(9'd27*E))+(((9'd28*F)+((9'd27*C)+(9'd8*B)))+(A*9'd28))))+(9'd5*K))+(9'd1*H)))+(9'd0*J)))+(((9'd14*N)+(L*9'd13))+(9'd22*O)))))+((9'd15*V)+((9'd21*X)+(9'd0*W)));
  wire [8:0] 
       total_volume = (((9'd26*W)+(X*9'd3))+((9'd13*T)+(((P*9'd18)+(9'd12*R))+(((9'd28*N)+(Q*9'd30))+(((9'd19*O)+((M*9'd9)+(((((9'd24*F)+((9'd20*H)+(G*9'd4)))+(((E*9'd0)+(D*9'd4))+((A*9'd27)+(9'd27*B))))+(C*9'd4))+((9'd15*J)+(9'd12*I)))))+((9'd5*K)+(L*9'd2)))))))+(((U*9'd18)+(S*9'd28))+(9'd16*V));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule


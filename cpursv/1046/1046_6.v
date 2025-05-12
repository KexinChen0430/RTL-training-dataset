
module var24_multi(input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,
                   output valid);

  wire [8:0]  min_value = 9'd120;
  wire [8:0]  max_weight = 9'd60;
  wire [8:0]  max_volume = 9'd60;
  wire [8:0] 
       total_value = (((((R*9'd7)+(S*9'd29))+((U*9'd24)+(T*9'd23)))+(((O*9'd18)+(((9'd16*M)+(9'd18*N))+((9'd30*K)+((((J*9'd15)+(9'd8*L))+(((9'd14*H)+(I*9'd6))+((F*9'd12)+((((C*9'd0)+(B*9'd8))+(9'd4*A))+((9'd10*E)+(D*9'd20))))))+(G*9'd18)))))+((9'd14*P)+(9'd7*Q))))+((9'd18*W)+(9'd5*X)))+(V*9'd3);
  wire [8:0] 
       total_weight = ((9'd21*X)+((9'd22*T)+(((V*9'd15)+(R*9'd26))+(((9'd1*S)+(9'd12*P))+(((Q*9'd23)+(((9'd22*O)+(9'd14*N))+(9'd8*M)))+(((J*9'd0)+(9'd13*L))+(((((9'd28*F)+((9'd20*I)+(9'd1*H)))+(((9'd6*G)+(9'd28*A))+((C*9'd27)+(B*9'd8))))+((9'd18*D)+(E*9'd27)))+(9'd5*K))))))))+((U*9'd26)+(W*9'd0));
  wire [8:0] 
       total_volume = ((W*9'd26)+(((X*9'd3)+(((U*9'd18)+(9'd12*R))+((((9'd30*Q)+(S*9'd28))+(((9'd18*P)+(((((9'd4*G)+(((F*9'd24)+((C*9'd4)+(9'd27*A)))+((9'd27*B)+(D*9'd4))))+(E*9'd0))+((J*9'd15)+(9'd12*I)))+(H*9'd20)))+((9'd5*K)+((9'd9*M)+(L*9'd2)))))+((O*9'd19)+(9'd28*N)))))+(T*9'd13)))+(V*9'd16);

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


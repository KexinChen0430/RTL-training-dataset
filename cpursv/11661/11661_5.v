
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((O*8'd18)+((M*8'd16)+(N*8'd18)))+(((8'd14*P)+(((J*8'd15)+(8'd30*K))+(L*8'd8)))+((((8'd18*G)+(H*8'd14))+(I*8'd6))+(((F*8'd12)+(E*8'd10))+(((8'd8*B)+(8'd4*A))+((D*8'd20)+(8'd0*C))))));
  wire [7:0] 
       total_weight = (8'd22*O)+(((P*8'd12)+((((N*8'd14)+(L*8'd13))+(((((8'd1*H)+(8'd0*J))+(G*8'd6))+((((8'd28*F)+(8'd27*E))+((D*8'd18)+(A*8'd28)))+((8'd8*B)+(C*8'd27))))+(8'd5*K)))+(I*8'd20)))+(8'd8*M));
  wire [7:0] 
       total_volume = ((N*8'd28)+(8'd18*P))+(((8'd19*O)+((((M*8'd9)+(((8'd12*I)+(((8'd27*A)+(C*8'd4))+((8'd27*B)+(E*8'd0))))+((D*8'd4)+(8'd24*F))))+((H*8'd20)+(G*8'd4)))+((8'd5*K)+(J*8'd15))))+(8'd2*L));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


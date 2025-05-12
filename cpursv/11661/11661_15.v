
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((N*8'd18)+((J*8'd15)+(8'd6*I)))+((((8'd30*K)+(L*8'd8))+(((8'd18*G)+(8'd14*H))+(8'd10*E)))+(((8'd12*F)+((B*8'd8)+(8'd0*C)))+((D*8'd20)+(8'd4*A)))))+((M*8'd16)+((8'd14*P)+(8'd18*O)));
  wire [7:0] 
       total_weight = (8'd14*N)+((((P*8'd12)+(O*8'd22))+((((H*8'd1)+(G*8'd6))+((J*8'd0)+((((8'd27*E)+(8'd28*F))+(((8'd28*A)+(B*8'd8))+(8'd18*D)))+(8'd27*C))))+((I*8'd20)+(L*8'd13))))+((K*8'd5)+(M*8'd8)));
  wire [7:0] 
       total_volume = (((((8'd12*I)+((K*8'd5)+(8'd2*L)))+((8'd20*H)+(8'd4*G)))+((((F*8'd24)+((C*8'd4)+(8'd27*B)))+(((8'd0*E)+(8'd4*D))+(A*8'd27)))+(J*8'd15)))+(((M*8'd9)+(8'd19*O))+(N*8'd28)))+(8'd18*P);

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


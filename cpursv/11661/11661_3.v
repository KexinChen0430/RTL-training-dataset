
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((((M*8'd16)+((((8'd12*F)+(I*8'd6))+(8'd14*H))+((((8'd10*E)+(8'd0*C))+(8'd8*B))+((A*8'd4)+(8'd20*D)))))+(8'd18*G))+(((J*8'd15)+(K*8'd30))+(8'd8*L)))+(P*8'd14))+((O*8'd18)+(8'd18*N));
  wire [7:0] 
       total_weight = (((O*8'd22)+(8'd12*P))+(8'd8*M))+((N*8'd14)+(((8'd20*I)+((K*8'd5)+(8'd13*L)))+(((8'd1*H)+(8'd0*J))+((8'd27*E)+(((8'd6*G)+(F*8'd28))+((8'd18*D)+((8'd27*C)+((8'd8*B)+(A*8'd28)))))))));
  wire [7:0] 
       total_volume = ((8'd18*P)+((((8'd19*O)+(8'd28*N))+((J*8'd15)+(K*8'd5)))+(((((((A*8'd27)+(B*8'd27))+(C*8'd4))+(8'd4*G))+(8'd4*D))+((8'd0*E)+(8'd24*F)))+((8'd12*I)+(H*8'd20)))))+((8'd2*L)+(8'd9*M));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


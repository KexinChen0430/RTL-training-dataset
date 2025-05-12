
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((8'd16*M)+(P*8'd14))+(O*8'd18))+((((8'd8*L)+(((8'd18*G)+(I*8'd6))+((((8'd10*E)+(F*8'd12))+(A*8'd4))+(((8'd0*C)+(8'd20*D))+(8'd8*B)))))+(H*8'd14))+(J*8'd15)))+((8'd18*N)+(K*8'd30));
  wire [7:0] 
       total_weight = (((M*8'd8)+((O*8'd22)+(8'd12*P)))+((((8'd20*I)+((8'd0*J)+(K*8'd5)))+(((H*8'd1)+(E*8'd27))+((((8'd8*B)+(((8'd27*C)+(8'd28*A))+(8'd18*D)))+(8'd28*F))+(G*8'd6))))+(N*8'd14)))+(L*8'd13);
  wire [7:0] 
       total_volume = ((((O*8'd19)+(N*8'd28))+(P*8'd18))+((8'd9*M)+(K*8'd5)))+((((8'd2*L)+(J*8'd15))+(((I*8'd12)+((8'd4*D)+(8'd0*E)))+((8'd24*F)+((8'd27*A)+((8'd27*B)+(8'd4*C))))))+((H*8'd20)+(8'd4*G)));

  assign valid = (total_weight <= max_weight) && 
                 (total_value >= min_value) && (total_volume <= max_volume);
endmodule


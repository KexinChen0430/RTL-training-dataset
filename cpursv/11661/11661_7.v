
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((M*8'd16)+(8'd14*P))+(8'd18*O))+(((8'd18*N)+((((8'd20*D)+((8'd0*C)+(B*8'd8)))+((A*8'd4)+(8'd10*E)))+(((G*8'd18)+(H*8'd14))+(8'd12*F))))+((8'd15*J)+(I*8'd6))))+((8'd8*L)+(8'd30*K));
  wire [7:0] 
       total_weight = ((8'd12*P)+(8'd8*M))+((((O*8'd22)+(N*8'd14))+(((H*8'd1)+(8'd20*I))+((K*8'd5)+((((D*8'd18)+(8'd28*F))+(G*8'd6))+((8'd27*E)+((A*8'd28)+((C*8'd27)+(B*8'd8))))))))+((8'd13*L)+(8'd0*J)));
  wire [7:0] 
       total_volume = ((((L*8'd2)+(8'd15*J))+(M*8'd9))+(((K*8'd5)+(G*8'd4))+((((I*8'd12)+(8'd20*H))+((D*8'd4)+(F*8'd24)))+(((E*8'd0)+((8'd4*C)+(A*8'd27)))+(B*8'd27)))))+(((P*8'd18)+(8'd28*N))+(O*8'd19));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


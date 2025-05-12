
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((8'd14*P)+(8'd18*O))+(8'd18*N))+((L*8'd8)+((((8'd16*M)+(8'd30*K))+((((H*8'd14)+((((8'd4*A)+(8'd10*E))+(8'd20*D))+(B*8'd8)))+(8'd0*C))+((F*8'd12)+(8'd18*G))))+((8'd6*I)+(8'd15*J))));
  wire [7:0] 
       total_weight = ((((O*8'd22)+(P*8'd12))+(8'd14*N))+(((8'd5*K)+((8'd0*J)+(((F*8'd28)+(E*8'd27))+((((D*8'd18)+(B*8'd8))+((A*8'd28)+(8'd27*C)))+(G*8'd6)))))+((H*8'd1)+(8'd20*I))))+((L*8'd13)+(M*8'd8));
  wire [7:0] 
       total_volume = (((P*8'd18)+(8'd28*N))+((8'd2*L)+(M*8'd9)))+(((O*8'd19)+((8'd12*I)+(8'd5*K)))+(((8'd15*J)+(((D+G)*8'd4)+((8'd4*C)+(((B*8'd27)+(8'd0*E))+(8'd27*A)))))+((H*8'd20)+(8'd24*F))));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


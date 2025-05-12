
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((N*8'd18)+((O*8'd18)+(P*8'd14)))+((((K*8'd30)+(8'd12*F))+(((E*8'd10)+(G*8'd18))+(((8'd20*D)+(A*8'd4))+((B*8'd8)+(8'd0*C)))))+((8'd6*I)+(8'd14*H))))+(((J*8'd15)+(L*8'd8))+(M*8'd16));
  wire [7:0] 
       total_weight = ((P*8'd12)+(O*8'd22))+((((K*8'd5)+(N*8'd14))+((((J*8'd0)+(8'd20*I))+((F*8'd28)+(G*8'd6)))+(((8'd1*H)+((8'd27*C)+(A*8'd28)))+(((8'd18*D)+(E*8'd27))+(B*8'd8)))))+((L*8'd13)+(M*8'd8)));
  wire [7:0] 
       total_volume = ((8'd28*N)+(8'd9*M))+((((P*8'd18)+(8'd19*O))+((((I*8'd12)+(8'd24*F))+(8'd20*H))+((G*8'd4)+(((B*8'd27)+(8'd0*E))+(((D*8'd4)+(8'd4*C))+(A*8'd27))))))+(((K*8'd5)+(J*8'd15))+(L*8'd2)));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule


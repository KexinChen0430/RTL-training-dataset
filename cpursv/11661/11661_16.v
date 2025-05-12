
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd18*N)+(8'd18*O))+(((P*8'd14)+((8'd30*K)+(8'd8*L)))+(((((((8'd12*F)+(I*8'd6))+(8'd14*H))+((((A*8'd4)+(C*8'd0))+(B*8'd8))+(G*8'd18)))+((E*8'd10)+(D*8'd20)))+(J*8'd15))+(8'd16*M)));
  wire [7:0] 
       total_weight = ((P*8'd12)+((N*8'd14)+(8'd8*M)))+(((8'd22*O)+((J*8'd0)+(I*8'd20)))+((((8'd28*F)+((8'd6*G)+(8'd1*H)))+(((D*8'd18)+(8'd27*C))+((E*8'd27)+((B*8'd8)+(8'd28*A)))))+((K*8'd5)+(L*8'd13))));
  wire [7:0] 
       total_volume = (((P*8'd18)+(8'd28*N))+((8'd9*M)+(8'd2*L)))+(((8'd19*O)+(J*8'd15))+((((K*8'd5)+(8'd12*I))+(H*8'd20))+(((((C*8'd4)+((8'd27*A)+(8'd27*B)))+(E*8'd0))+((F*8'd24)+(G*8'd4)))+(D*8'd4))));

  assign valid = (total_volume <= max_volume) && 
                 ((total_value >= min_value) && 
(total_weight <= max_weight));
endmodule


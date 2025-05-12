
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((O*8'd18)+(8'd14*P))+((((((8'd14*H)+(8'd6*I))+(8'd15*J))+(((8'd18*G)+((E*8'd10)+(F*8'd12)))+((((C*8'd0)+(8'd4*A))+(8'd8*B))+(8'd20*D))))+(N*8'd18))+(M*8'd16)))+((8'd8*L)+(K*8'd30));
  wire [7:0] 
       total_weight = ((((M*8'd8)+(8'd12*P))+(8'd22*O))+((8'd13*L)+(N*8'd14)))+((((8'd5*K)+(J*8'd0))+(((I*8'd20)+((8'd28*A)+(((8'd8*B)+(D*8'd18))+(8'd27*C))))+(((8'd27*E)+(8'd6*G))+(8'd28*F))))+(8'd1*H));
  wire [7:0] 
       total_volume = ((((8'd18*P)+(8'd19*O))+((((((8'd4*G)+(F*8'd24))+(8'd20*H))+(((D*8'd4)+((8'd4*C)+(8'd27*A)))+((8'd0*E)+(8'd27*B))))+(L*8'd2))+(I*8'd12)))+((8'd15*J)+(8'd5*K)))+((M*8'd9)+(N*8'd28));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


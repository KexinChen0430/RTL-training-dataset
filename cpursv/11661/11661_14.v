
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((8'd18*N)+((O*8'd18)+(8'd14*P)))+((M*8'd16)+(((((J*8'd15)+((((G*8'd18)+(A*8'd4))+((C*8'd0)+(8'd8*B)))+((E*8'd10)+(8'd20*D))))+(F*8'd12))+(8'd30*K))+((8'd6*I)+(8'd14*H)))))+(8'd8*L);
  wire [7:0] 
       total_weight = (((8'd12*P)+(8'd14*N))+(((O*8'd22)+(L*8'd13))+(((8'd0*J)+(8'd5*K))+((((((G*8'd6)+(E*8'd27))+((A*8'd28)+(8'd27*C)))+((8'd18*D)+(8'd8*B)))+((8'd1*H)+(8'd20*I)))+(F*8'd28)))))+(8'd8*M);
  wire [7:0] 
       total_volume = (((P*8'd18)+(8'd28*N))+(((O*8'd19)+(((((J*8'd15)+(8'd5*K))+(((B*8'd27)+(C*8'd4))+((8'd4*D)+(A*8'd27))))+(((E*8'd0)+(G*8'd4))+(8'd24*F)))+(H*8'd20)))+(I*8'd12)))+((M*8'd9)+(L*8'd2));

  assign valid = (total_weight <= max_weight) && 
                 ((total_value >= min_value) && 
(total_volume <= max_volume));
endmodule


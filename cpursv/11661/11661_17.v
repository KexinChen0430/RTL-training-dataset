
module var16_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P;
  output valid;
  wire [7:0]  min_value = 8'd120;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((8'd18*N)+((P*8'd14)+(O*8'd18)))+((((((8'd18*G)+(8'd10*E))+((((D*8'd20)+(8'd4*A))+(8'd8*B))+((C*8'd0)+(8'd12*F))))+(I*8'd6))+(8'd14*H))+((8'd16*M)+(8'd8*L))))+((K*8'd30)+(J*8'd15));
  wire [7:0] 
       total_weight = ((8'd12*P)+((((8'd5*K)+((((8'd20*I)+((F*8'd28)+(8'd1*H)))+((((8'd27*E)+(8'd6*G))+((8'd8*B)+(C*8'd27)))+((8'd18*D)+(A*8'd28))))+(8'd0*J)))+(O*8'd22))+((8'd8*M)+(L*8'd13))))+(N*8'd14);
  wire [7:0] 
       total_volume = (((8'd2*L)+((M*8'd9)+(N*8'd28)))+((((8'd12*I)+((J*8'd15)+(8'd5*K)))+((8'd0*E)+(F*8'd24)))+((((8'd4*G)+(8'd20*H))+(D*8'd4))+(((A*8'd27)+(C*8'd4))+(B*8'd27)))))+((O*8'd19)+(8'd18*P));

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule


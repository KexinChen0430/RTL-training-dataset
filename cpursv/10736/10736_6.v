
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((J*8'd15)+(H*8'd14))+(((K*8'd30)+(8'd6*I))+(((E*8'd10)+(8'd12*F))+(((B*8'd8)+(8'd4*A))+((G*8'd18)+((C*8'd0)+(D*8'd20))))));
  wire [7:0] 
       total_weight = (((J*8'd0)+(8'd5*K))+((F*8'd28)+(8'd6*G)))+((((8'd20*I)+(8'd1*H))+((D*8'd18)+(E*8'd27)))+((A*8'd28)+((B*8'd8)+(C*8'd27))));
  wire [7:0] 
       total_volume = (((G*8'd4)+((8'd12*I)+(8'd20*H)))+((J*8'd15)+((A*8'd27)+(((D*8'd4)+(B*8'd27))+((8'd24*F)+((8'd4*C)+(8'd0*E)))))))+(8'd5*K);

  assign valid = (total_value >= min_value) && 
                 ((total_weight <= max_weight) && 
(total_volume <= max_volume));
endmodule


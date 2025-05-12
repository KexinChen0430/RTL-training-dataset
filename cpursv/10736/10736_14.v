
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((8'd30*K)+((G*8'd18)+((8'd15*J)+(8'd6*I))))+(((8'd12*F)+((A*8'd4)+(8'd8*B)))+(((8'd20*D)+(C*8'd0))+((H*8'd14)+(8'd10*E))));
  wire [7:0] 
       total_weight = ((G*8'd6)+(((8'd27*E)+(((8'd27*C)+(D*8'd18))+(8'd8*B)))+(A*8'd28)))+(((F*8'd28)+(8'd1*H))+((K*8'd5)+((J*8'd0)+(I*8'd20))));
  wire [7:0] 
       total_volume = (((8'd20*H)+((((8'd0*E)+(G*8'd4))+(D*8'd4))+(((8'd27*A)+(C*8'd4))+(8'd27*B))))+((8'd15*J)+(F*8'd24)))+((8'd12*I)+(K*8'd5));

  assign valid = (total_weight <= max_weight) && 
                 ((total_volume <= max_volume) && 
(total_value >= min_value));
endmodule


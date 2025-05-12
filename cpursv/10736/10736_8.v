
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((J*8'd15)+(8'd6*I))+(G*8'd18))+((K*8'd30)+((8'd14*H)+(((8'd8*B)+((8'd0*C)+(D*8'd20)))+(((8'd10*E)+(8'd12*F))+(A*8'd4)))));
  wire [7:0] 
       total_weight = (((H*8'd1)+((8'd0*J)+(K*8'd5)))+(((((8'd27*C)+(E*8'd27))+(A*8'd28))+((8'd8*B)+(8'd18*D)))+(I*8'd20)))+((8'd28*F)+(8'd6*G));
  wire [7:0] 
       total_volume = (((K*8'd5)+(J*8'd15))+(I*8'd12))+(((F*8'd24)+(8'd4*G))+(((A*8'd27)+(8'd4*C))+(((8'd0*E)+((8'd27*B)+(8'd4*D)))+(H*8'd20))));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


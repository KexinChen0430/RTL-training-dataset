
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((I*8'd6)+((K*8'd30)+(8'd15*J)))+(8'd14*H))+((((8'd10*E)+(G*8'd18))+(D*8'd20))+(((8'd8*B)+((8'd0*C)+(8'd4*A)))+(8'd12*F)));
  wire [7:0] 
       total_weight = ((((D*8'd18)+(((8'd28*F)+(8'd8*B))+((8'd27*C)+(A*8'd28))))+((E*8'd27)+(8'd1*H)))+(((8'd5*K)+(I*8'd20))+(8'd0*J)))+(G*8'd6);
  wire [7:0] 
       total_volume = ((H*8'd20)+((I*8'd12)+(8'd15*J)))+(((8'd4*C)+((8'd27*B)+((8'd0*E)+(A*8'd27))))+(((D*8'd4)+((8'd24*F)+(G*8'd4)))+(8'd5*K)));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule


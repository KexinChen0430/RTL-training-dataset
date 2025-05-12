
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (G*8'd18)+(((H*8'd14)+((8'd15*J)+(K*8'd30)))+(((((8'd4*A)+(E*8'd10))+(B*8'd8))+(((C*8'd0)+(8'd20*D))+(F*8'd12)))+(I*8'd6)));
  wire [7:0] 
       total_weight = ((((8'd27*C)+(G*8'd6))+((8'd28*A)+(B*8'd8)))+(((8'd27*E)+(8'd18*D))+(F*8'd28)))+(((8'd20*I)+((8'd0*J)+(H*8'd1)))+(8'd5*K));
  wire [7:0] 
       total_volume = (((I*8'd12)+((8'd5*K)+(8'd15*J)))+(((((8'd27*A)+(B*8'd27))+((C*8'd4)+(D*8'd4)))+(E*8'd0))+((8'd20*H)+(G*8'd4))))+(F*8'd24);

  assign valid = (total_value >= min_value) && 
                 (total_volume <= max_volume) && (total_weight <= max_weight);
endmodule


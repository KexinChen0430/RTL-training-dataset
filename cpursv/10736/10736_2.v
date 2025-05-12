
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((8'd6*I)+((8'd30*K)+(8'd15*J)))+(8'd14*H))+((((B*8'd8)+(E*8'd10))+(A*8'd4))+(((8'd20*D)+(C*8'd0))+((G*8'd18)+(F*8'd12))));
  wire [7:0] 
       total_weight = ((((D*8'd18)+(C*8'd27))+(((B*8'd8)+(8'd27*E))+(A*8'd28)))+(8'd6*G))+((((8'd1*H)+(K*8'd5))+(J*8'd0))+((8'd28*F)+(I*8'd20)));
  wire [7:0] 
       total_volume = ((((B*8'd27)+(8'd0*E))+(A*8'd27))+(((G*8'd4)+(D*8'd4))+(C*8'd4)))+((((H*8'd20)+(I*8'd12))+(8'd24*F))+((8'd15*J)+(K*8'd5)));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule


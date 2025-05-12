
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((((8'd30*K)+(I*8'd6))+(8'd15*J))+((((C*8'd0)+(8'd20*D))+(((E*8'd10)+(8'd18*G))+(F*8'd12)))+((A*8'd4)+(8'd8*B))))+(8'd14*H);
  wire [7:0] 
       total_weight = ((((G*8'd6)+(8'd8*B))+(((A*8'd28)+(D*8'd18))+(8'd27*C)))+((E*8'd27)+(8'd28*F)))+((((8'd1*H)+(8'd0*J))+(8'd5*K))+(I*8'd20));
  wire [7:0] 
       total_volume = ((G*8'd4)+(8'd20*H))+((((B*8'd27)+((C*8'd4)+((E*8'd0)+(A*8'd27))))+((8'd24*F)+(D*8'd4)))+(((8'd5*K)+(8'd12*I))+(8'd15*J)));

  assign valid = (total_volume <= max_volume) && 
                 (total_weight <= max_weight) && (total_value >= min_value);
endmodule


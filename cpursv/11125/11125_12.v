
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((L*8'd8)+((J*8'd15)+(8'd16*M)))+(((G*8'd18)+(((8'd0*C)+(8'd8*B))+((8'd4*A)+(D*8'd20))))+((8'd30*K)+((8'd12*F)+(8'd10*E)))))+((8'd6*I)+(8'd14*H));
  wire [7:0] 
       total_weight = (((((D*8'd18)+(8'd27*E))+((8'd1*H)+(I*8'd20)))+((8'd27*C)+((A*8'd28)+(8'd8*B))))+((8'd5*K)+((8'd28*F)+(G*8'd6))))+((8'd0*J)+((M*8'd8)+(L*8'd13)));
  wire [7:0] 
       total_volume = (((8'd24*F)+(I*8'd12))+(((G*8'd4)+(8'd4*C))+((8'd4*D)+((8'd27*A)+((E*8'd0)+(8'd27*B))))))+((((M*8'd9)+(L*8'd2))+(J*8'd15))+((8'd20*H)+(8'd5*K)));

  assign valid = (total_weight <= max_weight) && 
                 (total_volume <= max_volume) && (total_value >= min_value);
endmodule


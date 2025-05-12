
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (((K*8'd30)+(8'd6*I))+((((J*8'd15)+(8'd18*G))+(((F*8'd12)+(D*8'd20))+((8'd14*H)+(((8'd10*E)+((8'd4*A)+(B*8'd8)))+(8'd0*C)))))+(8'd16*M)))+(L*8'd8);
  wire [7:0] 
       total_weight = (((((F*8'd28)+(8'd27*C))+((B*8'd8)+(8'd28*A)))+((D*8'd18)+((8'd6*G)+(E*8'd27))))+((8'd8*M)+((8'd13*L)+(8'd5*K))))+(((8'd0*J)+(8'd1*H))+(I*8'd20));
  wire [7:0] 
       total_volume = ((((8'd5*K)+(8'd9*M))+(8'd2*L))+((8'd4*D)+(((G*8'd4)+(I*8'd12))+((((B*8'd27)+(F*8'd24))+((A*8'd27)+(8'd4*C)))+(8'd0*E)))))+((J*8'd15)+(H*8'd20));

  assign valid = (total_value >= min_value) && 
                 (total_weight <= max_weight) && (total_volume <= max_volume);
endmodule


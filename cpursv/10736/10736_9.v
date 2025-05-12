
module var11_multi(A,B,C,D,E,F,G,H,I,J,K,valid);

  input  A,B,C,D,E,F,G,H,I,J,K;
  output valid;
  wire [7:0]  min_value = 8'd107;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = ((K*8'd30)+((((C*8'd0)+(B*8'd8))+(A*8'd4))+((((E*8'd10)+(8'd12*F))+(D*8'd20))+((8'd18*G)+(I*8'd6)))))+((8'd14*H)+(J*8'd15));
  wire [7:0] 
       total_weight = ((8'd6*G)+((K*8'd5)+(8'd0*J)))+((E*8'd27)+(((H*8'd1)+(I*8'd20))+((((D*8'd18)+(F*8'd28))+(B*8'd8))+((A*8'd28)+(C*8'd27)))));
  wire [7:0] 
       total_volume = (((G*8'd4)+(H*8'd20))+(K*8'd5))+((((8'd4*C)+(B*8'd27))+((A*8'd27)+(8'd4*D)))+(((8'd24*F)+(8'd0*E))+((8'd12*I)+(J*8'd15))));

  assign valid = (total_volume <= max_volume) && 
                 (total_value >= min_value) && (total_weight <= max_weight);
endmodule


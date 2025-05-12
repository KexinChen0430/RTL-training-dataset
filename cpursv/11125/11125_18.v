
module var13_multi(A,B,C,D,E,F,G,H,I,J,K,L,M,valid);

  input  A,B,C,D,E,F,G,H,I,J,K,L,M;
  output valid;
  wire [7:0]  min_value = 8'd121;
  wire [7:0]  max_weight = 8'd60;
  wire [7:0]  max_volume = 8'd60;
  wire [7:0] 
       total_value = (8'd30*K)+(((8'd18*G)+(((C*8'd0)+(E*8'd10))+(((F*8'd12)+(H*8'd14))+((8'd8*B)+((D*8'd20)+(A*8'd4))))))+(((J*8'd15)+(I*8'd6))+((8'd16*M)+(8'd8*L))));
  wire [7:0] 
       total_weight = ((8'd20*I)+((H*8'd1)+(J*8'd0)))+((((K*8'd5)+(8'd13*L))+(8'd8*M))+((((8'd28*A)+((D*8'd18)+(8'd8*B)))+((E+C)*8'd27))+((G*8'd6)+(F*8'd28))));
  wire [7:0] 
       total_volume = ((K*8'd5)+(H*8'd20))+((((L*8'd2)+(8'd9*M))+(J*8'd15))+((I*8'd12)+(((E*8'd0)+(8'd4*G))+((8'd4*C)+(((F*8'd24)+(D*8'd4))+((8'd27*A)+(B*8'd27)))))));

  assign valid = (total_value >= min_value) && 
                 ((total_volume <= max_volume) && 
(total_weight <= max_weight));
endmodule


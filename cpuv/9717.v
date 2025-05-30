module mux_32( 
           add, 
          i_0 , 
          i_1 , 
          i_2 , 
          i_3 , 
          i_4 , 
          i_5 , 
          i_6 , 
          i_7 , 
          i_8 , 
          i_9 , 
          i_10, 
          i_11, 
          i_12, 
          i_13, 
          i_14, 
          i_15, 
          i_16, 
          i_17, 
          i_18, 
          i_19, 
          i_20, 
          i_21, 
          i_22, 
          i_23, 
          i_24, 
          i_25, 
          i_26, 
          i_27, 
          i_28, 
          i_29, 
          i_30, 
          i_31, 
           o_i  
);
input   [4:0]                      add; 
input  signed    [15:0]           i_0 ; 
output reg signed  [15:0]         o_i; 
always@(*) 
  case(add) 
    5'd0 :o_i=i_0 ; 
    5'd1 :o_i=i_1 ; 
    5'd31:o_i=i_31; 
  endcase
endmodule 
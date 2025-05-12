module concat16 (
  input [15:0] string16,  
  output [31:0] string32  
);
  wire \string16[15] , \string16[14] , \string16[13] , \string16[12] ,
       \string16[11] , \string16[10] , \string16[9] , \string16[8] ,
       \string16[7] , \string16[6] , \string16[5] , \string16[4] ,
       \string16[3] , \string16[2] , \string16[1] , \string16[0] ;
  assign string32[15] = 1'b0;
  assign string32[14] = 1'b0;
  assign string32[0] = 1'b0;
  assign string32[31] = \string16[15] ;
  assign \string16[15]  = string16[15];
endmodule
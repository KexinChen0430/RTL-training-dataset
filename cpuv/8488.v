module circl_b( 
        input  wire [6:0] in_addr, 
        output reg  [6:0] out_word 
       );
always @* 
 case( in_addr ) 
  7'h01: out_word = 7'h0A; 
  7'h02: out_word = 7'h12; 
  7'h78: out_word = 7'h77; 
 default out_word = 7'h00; 
 endcase 
endmodule 
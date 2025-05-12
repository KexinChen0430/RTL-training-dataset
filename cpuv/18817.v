module main; 
   reg       clk; 
   reg [3:0] sig; 
   reg [7:0] thing; 
   always
     #10 clk = ~clk; 
   initial 
     begin
        $display ("\n<< BEGIN >>"); 
        case ( sig[3:0] ) 
          4'b0000: thing[0]     = 1'b1; 
          4'b0010: thing[2]     = 1'b1; 
          4'b0011: thing[9]     = 1'b1; 
        endcase 
        $display ("<< END  >>\n"); 
        $finish; 
     end 
endmodule 
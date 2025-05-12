module t (
   clk
   );
   input clk; 
   int cycle=0; 
   reg  [7:0] a_r; 
   wire [7:0] a_w; 
   reg  [7:0] b_r; 
   reg  [7:0] c_d_r, c_q_r; 
   assign a_w = a_r;
   always @(*) begin
     a_r = 0; 
     b_r = a_w;  
     a_r = c_q_r; 
     c_d_r = c_q_r; 
   end
   always @(posedge clk) begin
     cycle <= cycle+1; 
     if (cycle==0) begin
       c_q_r <= 8'b0; 
     end
     else begin
       c_q_r <= c_d_r+1; 
`ifdef TEST_VERBOSE
       $display("[%0t] a_r=%0d, b_r=%0d", $time, a_r, b_r); 
`endif
     end
     if (cycle >= 10) begin
       if (b_r==9) begin
         $write("*-* All Finished *-*\n"); 
         $finish; 
       end
       else begin
         $stop; 
       end
     end
   end
endmodule
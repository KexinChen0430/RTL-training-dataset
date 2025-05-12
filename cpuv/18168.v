module t (   
   clk                    
   );
   input clk;             
   integer cyc; initial cyc = 0; 
   logic [1:0][27:0] ch01; 
   logic [1:0][27:0] ch02; 
   logic [1:0][27:0] ch03; 
   logic [27:0] ch04[1:0]; 
   always @ (posedge clk) begin 
      ch01 <= {{2{28'd4}}}; 
      ch02 <= {{2{cyc}}};   
      ch03 <= 56'd0;        
      ch04 <= 56'd0;        
      $display("ch01: %0x %0x", ch01[0], ch01[1]); 
      $display("ch01: %0x %0x", ch02[0], ch02[1]); 
      $display("ch01: %0x %0x", ch03[0], ch03[1]); 
      $display("ch01: %0x %0x", ch04[0], ch04[1]); 
   end
endmodule
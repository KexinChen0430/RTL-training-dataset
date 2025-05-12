module main; 
   integer i = 8; 
   time    t = 0; 
   initial begin 
      #1 if (i !== 8) begin 
         $display("FAILED -- i == %b", i); 
         $finish; 
      end
      if (t !== 0) begin 
         $display("FAILED -- t == %b", t); 
         $finish; 
      end
      $display("PASSED"); 
   end 
endmodule 
module main;
   reg [3:0] test;
   initial begin
      test = {{0{1'b1}}, 1'b0};
      if (test !== 4'b0000) begin
         $display("FAILED -- {0{1'b1} == %b", test);
         $finish; 
      end
      test = {1{1'b1}};
      if (test !== 4'b0001) begin
         $display("FAILED -- {1{1'b1} == %b", test);
         $finish; 
      end
      test = {2{1'b1}};
      if (test !== 4'b0011) begin
         $display("FAILED -- {2{1'b1} == %b", test);
         $finish; 
      end
      test = {3{1'b1}};
      if (test !== 4'b0111) begin
         $display("FAILED -- {3{1'b1} == %b", test);
         $finish; 
      end
      test = {4{1'b1}};
      if (test !== 4'b1111) begin
         $display("FAILED -- {4{1'b1} == %b", test);
         $finish; 
      end
      test = {5{1'b1}};
      if (test !== 4'b1111) begin
         $display("FAILED -- {5{1'b1} == %b", test);
         $finish; 
      end
      $display("PASSED");
   end 
endmodule 
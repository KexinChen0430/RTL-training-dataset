module test;
   reg [31:0] buff[256*2*2-1:0];
   reg [31:0] x;
   initial
      begin
         buff[0] = 0;
         x = 256;
         buff[x+0] = 1234;
         if (buff[0] != 0) begin
            $display("FAILED");
            $finish;
         end
         $display("PASSED");
      end
endmodule
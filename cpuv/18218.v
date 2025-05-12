module inst2 (
   cyc, i0, i1
   );
   input [31:0] cyc;
   input [1:0] 	i0;
   input [1:0] 	i1;
   initial begin
      if (cyc==32'h1) 
         $write("[%0t] i0=%d i1=%d\n", $time, i0, i1);
   end
endmodule
module slow (out);
   output out;
   reg    out;
   initial begin
      #0 out = 0;
      #1 out = 1; 
   end
endmodule
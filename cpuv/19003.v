module fast (out);
   timeunit 10us/1us;
   output out;
   reg out;
   initial begin
      #0 out = 0;
      #1 out = 1; 
   end
endmodule
module sub #
  (
   parameter P_START = 1, 
   parameter P_STOP  = 0  
   )(
     );
   initial begin
      for (int i = P_START; i >= P_STOP; --i) begin
         $display("%m %0d..%0d i=%0d", P_START, P_STOP, i);
      end
   end
endmodule
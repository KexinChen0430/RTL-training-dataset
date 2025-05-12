module test (
   clk
   );
   input clk; 
   t_pinid  e;
   int      myarray1 [] = new [e.num];
   always @(posedge clk) begin
`ifdef TEST_VERBOSE
      $write ("Enumeration has %d members\n", e.num);
`endif
      e = e.first;
      forever begin
         myarray1[e] <= e.prev;
`ifdef TEST_VERBOSE
         $write ("myarray1[%d] (enum %s) = %d\n", e, e.name, myarray1[e]);
`endif
         if (e == e.last) begin
            break;
         end
         else begin
            e = e.next;
         end
      end
   end
endmodule
module foo0(input wire x, output wire y);
   assign y = ~x;
   initial begin
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
module ps (input printclk);
   `INLINE_MODULE
   always @ (posedge printclk) $write("[%0t] %m: Clocked\n", $time);
endmodule
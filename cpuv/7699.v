module \$__outpad (input I, output O);
   cycloneive_io_obuf _TECHMAP_REPLACE_ (.o(O), .i(I), .oe(1'b1));
endmodule
module \$__inpad (input I, output O);
   cyclonev_io_ibuf _TECHMAP_REPLACE_ (.o(O), .i(I), .ibar(1'b0));
endmodule
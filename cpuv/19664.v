module sub2 ();
   parameter [31:0] IN = 99;
   parameter FLAVOR = 2;
`ifdef TEST_VERBOSE
   initial $display("%m");
`endif
endmodule
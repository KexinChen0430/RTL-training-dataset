module sub1 ();
   parameter [31:0] IN = 99;
   parameter FLAVOR = 1;
`ifdef TEST_VERBOSE
   initial $display("%m");
`endif
endmodule
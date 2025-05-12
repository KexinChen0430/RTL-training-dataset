module sub;
   reg subsig1 ;
   reg subsig2 ;
`ifdef iverilog
   wire redundant = subsig1 | subsig2;
`endif
endmodule
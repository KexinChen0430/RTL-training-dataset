module $__XILINX_TINOUTPAD (
    input I,   
    input OE,  
    output O,  
    inout IO   
);
  IOBUF _TECHMAP_REPLACE_ (
    .I(I),   
    .O(O),   
    .T(~OE), 
    .IO(IO)  
  );
endmodule 
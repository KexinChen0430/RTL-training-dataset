module $__XILINX_TOUTPAD (
    input I,   
    input OE,  
    output O   
);
  OBUFT _TECHMAP_REPLACE_ (
    .I(I),  
    .O(O),  
    .T(~OE) 
  );
endmodule 

module drv(input  colSelA,
           input  colSelB,
           input  colSelC,
           input  datai,
           output datao);

  assign datao = colSelA & (colSelB & (datai & colSelC));
endmodule



module drv(input  colSelA,
           input  colSelB,
           input  colSelC,
           input  datai,
           output datao);

  assign datao = (colSelB & (datai & colSelC)) & colSelA;
endmodule


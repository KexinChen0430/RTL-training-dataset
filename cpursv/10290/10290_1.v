
module drv(input  colSelA,
           input  colSelB,
           input  colSelC,
           input  datai,
           output datao);

  assign datao = (colSelA & datai) & (colSelB & colSelC);
endmodule


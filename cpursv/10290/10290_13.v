
module drv(input  colSelA,
           input  colSelB,
           input  colSelC,
           input  datai,
           output datao);

  assign datao = (colSelB & colSelA) & (colSelC & datai);
endmodule



module drv(input  colSelA,
           input  colSelB,
           input  colSelC,
           input  datai,
           output datao);

  assign datao = (colSelC & colSelA) & (colSelB & datai);
endmodule


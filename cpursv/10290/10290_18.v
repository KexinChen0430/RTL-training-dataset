
module drv(input  colSelA,
           input  colSelB,
           input  colSelC,
           input  datai,
           output datao);

  assign datao = ((colSelB & colSelC) & datai) & colSelA;
endmodule


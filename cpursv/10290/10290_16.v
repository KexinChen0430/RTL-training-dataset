
module drv(input  colSelA,
           input  colSelB,
           input  colSelC,
           input  datai,
           output datao);

  assign datao = (datai & colSelB) & (colSelA & colSelC);
endmodule


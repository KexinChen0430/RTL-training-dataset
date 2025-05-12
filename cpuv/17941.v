module arr_rev
  (
   input  var logic arrbkw [1:0] ,
   output var logic y0,
   output var logic y1
   );
   always_comb y0 = arrbkw[0];
   always_comb y1 = arrbkw[1];
endmodule
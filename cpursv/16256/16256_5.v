
module mux4  #(parameter  WIDTH = 32, DISABLED = 0)
  (input  en,
   input  [1:0] sel,
   input  [WIDTH+(0-1):0] i0,
   input  [WIDTH+(0-1):0] i1,
   input  [WIDTH+(0-1):0] i2,
   input  [WIDTH+(0-1):0] i3,
   output [WIDTH+(0-1):0] o);

  assign o = en ? (sel[1] ? (sel[0] ? i3 : i2) : 
(sel[0] ? i1 : i0) : DISABLED;
endmodule


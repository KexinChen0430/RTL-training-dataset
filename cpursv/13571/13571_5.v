
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc >= (2+hs)) && 
((vc >= vs) && (vc <= (2+vs)) && (hc <= (hs+13)));
  wire 
       b = (vc >= (2+vs)) && ((vc <= (14+vs)) && (hc >= (hs+13))) && 
(hc <= (15+hs));
  wire 
       c = (vc >= (16+vs)) && 
((hc <= (15+hs)) && (vc <= (28+vs)) && (hc >= (hs+13)));
  wire 
       d = (hc <= (hs+13)) && (hc >= (2+hs)) && 
((vc >= (28+vs)) && (vc <= (30+vs)));
  wire 
       e = (hc <= (2+hs)) && ((vc >= (16+vs)) && (hc >= hs)) && 
(vc <= (28+vs));
  wire 
       f = (hc <= (2+hs)) && (vc <= (14+vs)) && 
((hc >= hs) && (vc >= (2+vs)));
  wire 
       g = (vc >= (14+vs)) && (vc <= (16+vs)) && 
((hc <= (hs+13)) && (hc >= (2+hs)));

  assign yes = (num == 0) ? (((c | b) | d) | ((f | a) | e)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? ((b | e) | ((d | g) | a)) : 
               (num == 3) ? (b | (((d | g) | a) | c)) : 
               (num == 4) ? (((c | b) | f) | g) : 
               (num == 5) ? ((f | a) | ((d | c) | g)) : 
               (num == 6) ? ((d | f) | (((e | g) | a) | c)) : 
               (num == 7) ? ((c | b) | a) : 
               (num == 8) ? (((b | f) | e) | (((d | g) | a) | c)) : 
               (num == 9) ? (((g | b) | d) | (a | (c | f))) : 0;
endmodule


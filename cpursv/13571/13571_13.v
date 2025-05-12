
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc >= (hs+2)) && 
((hc <= (hs+13)) && ((vc <= (2+vs)) && (vc >= vs)));
  wire 
       b = (hc <= (15+hs)) && (hc >= (hs+13)) && 
((vc <= (14+vs)) && (vc >= (2+vs)));
  wire 
       c = (hc >= (hs+13)) && (vc >= (16+vs)) && (hc <= (15+hs)) && 
(vc <= (28+vs));
  wire 
       d = (vc >= (28+vs)) && 
((hc <= (hs+13)) && (hc >= (hs+2)) && (vc <= (vs+30)));
  wire 
       e = (vc <= (28+vs)) && ((vc >= (16+vs)) && (hc <= (hs+2))) && 
(hc >= hs);
  wire 
       f = (hc <= (hs+2)) && (hc >= hs) && (vc <= (14+vs)) && 
(vc >= (2+vs));
  wire 
       g = (vc <= (16+vs)) && (hc <= (hs+13)) && 
((vc >= (14+vs)) && (hc >= (hs+2)));

  assign yes = (num == 0) ? ((((c | f) | a) | b) | (e | d)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? (e | ((g | b) | (a | d))) : 
               (num == 3) ? (c | ((g | b) | (a | d))) : 
               (num == 4) ? (((c | g) | f) | b) : 
               (num == 5) ? (((c | f) | a) | (g | d)) : 
               (num == 6) ? (((c | f) | a) | ((e | g) | d)) : 
               (num == 7) ? (a | (c | b)) : 
               (num == 8) ? (((e | d) | (c | g)) | ((b | f) | a)) : 
               (num == 9) ? (((a | d) | g) | (f | (c | b))) : 0;
endmodule


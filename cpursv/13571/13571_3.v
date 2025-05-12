
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc <= (vs+2)) && (hc >= (hs+2)) && (vc >= vs) && 
(hc <= (hs+13));
  wire 
       b = (hc >= (hs+13)) && (vc <= (vs+14)) && 
((vc >= (vs+2)) && (hc <= (15+hs)));
  wire 
       c = (hc <= (15+hs)) && (vc <= (28+vs)) && 
((hc >= (hs+13)) && (vc >= (16+vs)));
  wire 
       d = (vc <= (30+vs)) && (hc <= (hs+13)) && 
((vc >= (28+vs)) && (hc >= (hs+2)));
  wire 
       e = (hc <= (hs+2)) && (vc >= (16+vs)) && 
((hc >= hs) && (vc <= (28+vs)));
  wire 
       f = (hc <= (hs+2)) && (vc <= (vs+14)) && (vc >= (vs+2)) && 
(hc >= hs);
  wire 
       g = (hc >= (hs+2)) && (vc <= (16+vs)) && 
((vc >= (vs+14)) && (hc <= (hs+13)));

  assign yes = (num == 0) ? (((c | b) | (a | e)) | (f | d)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? (((g | a) | b) | (e | d)) : 
               (num == 3) ? ((c | (g | d)) | (a | b)) : 
               (num == 4) ? (((c | b) | f) | g) : 
               (num == 5) ? ((f | (c | a)) | (g | d)) : 
               (num == 6) ? ((c | e) | ((d | a) | (g | f))) : 
               (num == 7) ? (a | (c | b)) : 
               (num == 8) ? (((f | (a | b)) | (c | (g | d))) | e) : 
               (num == 9) ? ((f | (a | b)) | (c | (g | d))) : 0;
endmodule


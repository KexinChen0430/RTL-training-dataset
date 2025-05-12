
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc <= (2+vs)) && (hc >= (hs+2)) && (hc <= (13+hs)) && 
(vc >= vs);
  wire 
       b = (hc >= (13+hs)) && 
((vc >= (2+vs)) && (vc <= (vs+14)) && (hc <= (15+hs)));
  wire 
       c = (hc <= (15+hs)) && (hc >= (13+hs)) && 
((vc >= (16+vs)) && (vc <= (28+vs)));
  wire 
       d = (vc <= (vs+30)) && (hc <= (13+hs)) && (vc >= (28+vs)) && 
(hc >= (hs+2));
  wire 
       e = (vc <= (28+vs)) && 
((hc >= hs) && (hc <= (hs+2)) && (vc >= (16+vs)));
  wire 
       f = (vc >= (2+vs)) && (vc <= (vs+14)) && 
((hc >= hs) && (hc <= (hs+2)));
  wire 
       g = (hc <= (13+hs)) && 
((vc <= (16+vs)) && (vc >= (vs+14)) && (hc >= (hs+2)));

  assign yes = (num == 0) ? ((d | (e | f)) | ((c | a) | b)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? (((b | d) | g) | (e | a)) : 
               (num == 3) ? ((g | (c | a)) | (b | d)) : 
               (num == 4) ? ((g | (c | b)) | f) : 
               (num == 5) ? ((a | (g | f)) | (c | d)) : 
               (num == 6) ? ((e | (a | f)) | (d | (c | g))) : 
               (num == 7) ? ((c | a) | b) : 
               (num == 8) ? ((g | (c | b)) | ((f | (d | a)) | e)) : 
               (num == 9) ? ((d | f) | ((g | (c | a)) | b)) : 0;
endmodule


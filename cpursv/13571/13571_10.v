
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc >= (2+hs)) && (vc <= (2+vs)) && 
((hc <= (hs+13)) && (vc >= vs));
  wire 
       b = (hc <= (hs+15)) && (vc >= (2+vs)) && 
((hc >= (hs+13)) && (vc <= (14+vs)));
  wire 
       c = (vc <= (28+vs)) && (vc >= (vs+16)) && (hc >= (hs+13)) && 
(hc <= (hs+15));
  wire 
       d = (hc >= (2+hs)) && (vc >= (28+vs)) && 
((hc <= (hs+13)) && (vc <= (30+vs)));
  wire 
       e = (vc <= (28+vs)) && (vc >= (vs+16)) && 
((hc >= hs) && (hc <= (2+hs)));
  wire 
       f = (hc >= hs) && 
((vc >= (2+vs)) && ((vc <= (14+vs)) && (hc <= (2+hs))));
  wire 
       g = (vc >= (14+vs)) && (hc >= (2+hs)) && 
((vc <= (vs+16)) && (hc <= (hs+13)));

  assign yes = (num == 0) ? ((b | d) | (((e | f) | a) | c)) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? ((e | a) | (b | (g | d))) : 
               (num == 3) ? (c | ((b | d) | (g | a))) : 
               (num == 4) ? ((g | f) | (b | c)) : 
               (num == 5) ? ((f | (g | d)) | (c | a)) : 
               (num == 6) ? ((((e | f) | a) | c) | (g | d)) : 
               (num == 7) ? (c | (b | a)) : 
               (num == 8) ? ((b | ((e | c) | a)) | (f | (g | d))) : 
               (num == 9) ? ((c | (b | a)) | (f | (g | d))) : 0;
endmodule


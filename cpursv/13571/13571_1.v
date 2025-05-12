
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc >= vs) && (vc <= (2+vs)) && 
((hc <= (13+hs)) && (hc >= (hs+2)));
  wire 
       b = (vc >= (2+vs)) && (hc >= (13+hs)) && 
((vc <= (14+vs)) && (hc <= (hs+15)));
  wire 
       c = (vc >= (16+vs)) && 
((hc >= (13+hs)) && 
((hc <= (hs+15)) && (vc <= (28+vs))));
  wire 
       d = (hc <= (13+hs)) && (hc >= (hs+2)) && 
((vc >= (28+vs)) && (vc <= (30+vs)));
  wire 
       e = (hc <= (hs+2)) && (hc >= hs) && 
((vc >= (16+vs)) && (vc <= (28+vs)));
  wire 
       f = (vc <= (14+vs)) && (hc >= hs) && 
((hc <= (hs+2)) && (vc >= (2+vs)));
  wire 
       g = (hc <= (13+hs)) && (hc >= (hs+2)) && 
((vc >= (14+vs)) && (vc <= (16+vs)));

  assign yes = (num == 0) ? ((e | (d | f)) | (a | (c | b))) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? ((e | (g | d)) | (b | a)) : 
               (num == 3) ? (((c | a) | g) | (b | d)) : 
               (num == 4) ? ((f | (b | g)) | c) : 
               (num == 5) ? ((f | (g | (a | d))) | c) : 
               (num == 6) ? (g | ((d | (c | (a | f))) | e)) : 
               (num == 7) ? (a | (c | b)) : 
               (num == 8) ? ((g | ((b | d) | f)) | ((c | a) | e)) : 
               (num == 9) ? ((c | (a | (b | g))) | (d | f)) : 0;
endmodule


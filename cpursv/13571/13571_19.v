
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc >= vs) && (hc <= (13+hs)) && 
((hc >= (hs+2)) && (vc <= (2+vs)));
  wire 
       b = (hc <= (hs+15)) && (vc >= (2+vs)) && 
((hc >= (13+hs)) && (vc <= (vs+14)));
  wire 
       c = (vc <= (vs+28)) && (hc <= (hs+15)) && 
((vc >= (16+vs)) && (hc >= (13+hs)));
  wire 
       d = (hc >= (hs+2)) && (vc >= (vs+28)) && 
((vc <= (30+vs)) && (hc <= (13+hs)));
  wire 
       e = (hc <= (hs+2)) && (hc >= hs) && (vc <= (vs+28)) && 
(vc >= (16+vs));
  wire 
       f = (hc <= (hs+2)) && (hc >= hs) && (vc >= (2+vs)) && 
(vc <= (vs+14));
  wire 
       g = (vc >= (vs+14)) && 
((hc <= (13+hs)) && ((hc >= (hs+2)) && (vc <= (16+vs))));

  assign yes = (num == 0) ? (((e | f) | d) | ((a | c) | b)) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? ((b | e) | (d | (a | g))) : 
               (num == 3) ? (((c | d) | g) | (b | a)) : 
               (num == 4) ? ((g | f) | (b | c)) : 
               (num == 5) ? (((c | d) | (a | g)) | f) : 
               (num == 6) ? ((e | (f | c)) | (d | (a | g))) : 
               (num == 7) ? ((a | c) | b) : 
               (num == 8) ? (c | ((((a | e) | f) | b) | (g | d))) : 
               (num == 9) ? (((c | d) | (a | g)) | (f | b)) : 0;
endmodule


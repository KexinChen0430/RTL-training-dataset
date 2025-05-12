
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc >= vs) && (vc <= (2+vs)) && (hc >= (2+hs)) && 
(hc <= (13+hs));
  wire 
       b = (hc <= (15+hs)) && (hc >= (13+hs)) && 
((vc <= (vs+14)) && (vc >= (2+vs)));
  wire 
       c = (hc >= (13+hs)) && 
((hc <= (15+hs)) && 
((vc >= (16+vs)) && (vc <= (vs+28))));
  wire 
       d = (hc >= (2+hs)) && (vc <= (vs+30)) && 
((hc <= (13+hs)) && (vc >= (vs+28)));
  wire 
       e = (vc >= (16+vs)) && (vc <= (vs+28)) && 
((hc >= hs) && (hc <= (2+hs)));
  wire 
       f = (vc <= (vs+14)) && ((hc >= hs) && (hc <= (2+hs))) && 
(vc >= (2+vs));
  wire 
       g = (vc >= (vs+14)) && ((hc >= (2+hs)) && (hc <= (13+hs))) && 
(vc <= (16+vs));

  assign yes = (num == 0) ? (((d | a) | e) | ((b | c) | f)) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? (((d | a) | e) | (g | b)) : 
               (num == 3) ? ((b | c) | (g | (d | a))) : 
               (num == 4) ? (c | ((f | g) | b)) : 
               (num == 5) ? (((a | f) | (d | c)) | g) : 
               (num == 6) ? ((d | (g | c)) | (a | (e | f))) : 
               (num == 7) ? ((b | c) | a) : 
               (num == 8) ? (((b | (f | d)) | (e | g)) | (c | a)) : 
               (num == 9) ? ((g | a) | ((c | f) | (d | b))) : 0;
endmodule


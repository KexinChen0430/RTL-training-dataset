
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc >= (2+hs)) && (vc <= (2+vs)) && 
((hc <= (13+hs)) && (vc >= vs));
  wire 
       b = (hc <= (15+hs)) && (vc <= (vs+14)) && 
((hc >= (13+hs)) && (vc >= (2+vs)));
  wire 
       c = (vc >= (vs+16)) && (vc <= (28+vs)) && 
((hc >= (13+hs)) && (hc <= (15+hs)));
  wire 
       d = (hc >= (2+hs)) && (vc >= (28+vs)) && 
((vc <= (vs+30)) && (hc <= (13+hs)));
  wire 
       e = (hc >= hs) && (vc <= (28+vs)) && 
((hc <= (2+hs)) && (vc >= (vs+16)));
  wire 
       f = (vc <= (vs+14)) && (hc >= hs) && 
((hc <= (2+hs)) && (vc >= (2+vs)));
  wire 
       g = (vc >= (vs+14)) && (hc >= (2+hs)) && 
((hc <= (13+hs)) && (vc <= (vs+16)));

  assign yes = (num == 0) ? ((f | (e | d)) | ((a | b) | c)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? (((b | g) | a) | (e | d)) : 
               (num == 3) ? (a | (b | (g | (c | d)))) : 
               (num == 4) ? ((b | (g | f)) | c) : 
               (num == 5) ? (f | ((g | c) | (d | a))) : 
               (num == 6) ? (((e | c) | (g | d)) | (f | a)) : 
               (num == 7) ? ((a | b) | c) : 
               (num == 8) ? ((a | c) | ((f | (e | d)) | (b | g))) : 
               (num == 9) ? ((((a | b) | c) | f) | (g | d)) : 0;
endmodule



module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc <= (13+hs)) && 
((vc >= vs) && ((hc >= (hs+2)) && (vc <= (2+vs))));
  wire 
       b = (vc <= (vs+14)) && (hc >= (13+hs)) && 
((hc <= (15+hs)) && (vc >= (2+vs)));
  wire 
       c = (vc >= (16+vs)) && (hc >= (13+hs)) && 
((hc <= (15+hs)) && (vc <= (vs+28)));
  wire 
       d = (hc >= (hs+2)) && 
((vc <= (vs+30)) && 
((hc <= (13+hs)) && (vc >= (vs+28))));
  wire 
       e = (vc >= (16+vs)) && ((vc <= (vs+28)) && (hc >= hs)) && 
(hc <= (hs+2));
  wire 
       f = (vc >= (2+vs)) && 
((vc <= (vs+14)) && ((hc >= hs) && (hc <= (hs+2))));
  wire 
       g = (vc >= (vs+14)) && (hc >= (hs+2)) && 
((vc <= (16+vs)) && (hc <= (13+hs)));

  assign yes = (num == 0) ? ((c | b) | ((a | (e | f)) | d)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? ((d | e) | (b | (g | a))) : 
               (num == 3) ? (d | (a | ((g | c) | b))) : 
               (num == 4) ? (((c | f) | g) | b) : 
               (num == 5) ? (a | ((d | (g | f)) | c)) : 
               (num == 6) ? ((g | c) | ((a | (e | f)) | d)) : 
               (num == 7) ? (b | (a | c)) : 
               (num == 8) ? ((((e | f) | d) | (b | g)) | (a | c)) : 
               (num == 9) ? (((d | a) | f) | ((g | c) | b)) : 0;
endmodule


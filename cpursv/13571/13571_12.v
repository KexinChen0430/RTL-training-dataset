
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc >= vs) && (hc <= (13+hs)) && 
((vc <= (vs+2)) && (hc >= (hs+2)));
  wire 
       b = (hc <= (15+hs)) && (vc <= (vs+14)) && 
((vc >= (vs+2)) && (hc >= (13+hs)));
  wire 
       c = (vc >= (16+vs)) && (hc <= (15+hs)) && (vc <= (vs+28)) && 
(hc >= (13+hs));
  wire 
       d = (hc >= (hs+2)) && (hc <= (13+hs)) && 
((vc >= (vs+28)) && (vc <= (vs+30)));
  wire 
       e = (hc >= hs) && 
((vc <= (vs+28)) && (vc >= (16+vs)) && (hc <= (hs+2)));
  wire 
       f = (vc <= (vs+14)) && 
((hc <= (hs+2)) && ((hc >= hs) && (vc >= (vs+2))));
  wire 
       g = (vc <= (16+vs)) && (hc <= (13+hs)) && 
((vc >= (vs+14)) && (hc >= (hs+2)));

  assign yes = (num == 0) ? (((b | a) | c) | (e | (f | d))) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? ((e | d) | ((g | b) | a)) : 
               (num == 3) ? (((b | a) | c) | (d | g)) : 
               (num == 4) ? (((g | c) | b) | f) : 
               (num == 5) ? (a | ((g | c) | (f | d))) : 
               (num == 6) ? ((d | a) | (e | (f | (g | c)))) : 
               (num == 7) ? ((b | a) | c) : 
               (num == 8) ? ((a | c) | (((g | f) | (b | e)) | d)) : 
               (num == 9) ? ((c | f) | ((b | a) | (d | g))) : 0;
endmodule


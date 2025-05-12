
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc >= vs) && (hc <= (hs+13)) && 
((vc <= (vs+2)) && (hc >= (hs+2)));
  wire 
       b = (hc <= (15+hs)) && 
((hc >= (hs+13)) && (vc >= (vs+2)) && (vc <= (14+vs)));
  wire 
       c = (hc >= (hs+13)) && (hc <= (15+hs)) && (vc <= (vs+28)) && 
(vc >= (16+vs));
  wire 
       d = (vc <= (vs+30)) && (hc <= (hs+13)) && 
((vc >= (vs+28)) && (hc >= (hs+2)));
  wire 
       e = (hc >= hs) && 
((vc >= (16+vs)) && (vc <= (vs+28)) && (hc <= (hs+2)));
  wire 
       f = (vc <= (14+vs)) && (hc <= (hs+2)) && 
((hc >= hs) && (vc >= (vs+2)));
  wire 
       g = (vc <= (16+vs)) && (vc >= (14+vs)) && 
((hc <= (hs+13)) && (hc >= (hs+2)));

  assign yes = (num == 0) ? ((b | (c | f)) | ((e | d) | a)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? ((d | (g | a)) | (b | e)) : 
               (num == 3) ? (((a | b) | (g | d)) | c) : 
               (num == 4) ? ((c | b) | (g | f)) : 
               (num == 5) ? ((d | (g | a)) | (c | f)) : 
               (num == 6) ? ((g | (f | d)) | (e | (a | c))) : 
               (num == 7) ? (a | (c | b)) : 
               (num == 8) ? (((b | f) | a) | (g | (c | (e | d)))) : 
               (num == 9) ? (a | ((b | f) | (d | (c | g)))) : 0;
endmodule


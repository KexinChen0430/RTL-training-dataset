
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc <= (2+vs)) && ((hc >= (2+hs)) && (hc <= (13+hs))) && 
(vc >= vs);
  wire 
       b = (hc <= (hs+15)) && (hc >= (13+hs)) && 
((vc >= (2+vs)) && (vc <= (vs+14)));
  wire 
       c = (hc <= (hs+15)) && (vc <= (vs+28)) && 
((vc >= (16+vs)) && (hc >= (13+hs)));
  wire 
       d = (vc <= (vs+30)) && (hc <= (13+hs)) && 
((vc >= (vs+28)) && (hc >= (2+hs)));
  wire 
       e = (vc >= (16+vs)) && (vc <= (vs+28)) && 
((hc <= (2+hs)) && (hc >= hs));
  wire 
       f = (hc >= hs) && ((vc >= (2+vs)) && (vc <= (vs+14))) && 
(hc <= (2+hs));
  wire 
       g = (hc <= (13+hs)) && (vc >= (vs+14)) && 
((hc >= (2+hs)) && (vc <= (16+vs)));

  assign yes = (num == 0) ? (((c | d) | ((a | f) | e)) | b) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? ((e | d) | ((a | g) | b)) : 
               (num == 3) ? (((g | c) | d) | (b | a)) : 
               (num == 4) ? ((c | b) | (f | g)) : 
               (num == 5) ? (((c | (f | d)) | a) | g) : 
               (num == 6) ? ((c | (f | d)) | ((a | g) | e)) : 
               (num == 7) ? ((a | c) | b) : 
               (num == 8) ? (((((g | c) | e) | b) | (f | d)) | a) : 
               (num == 9) ? ((((g | c) | d) | b) | (a | f)) : 0;
endmodule


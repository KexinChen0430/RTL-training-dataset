
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc <= (13+hs)) && 
((vc >= vs) && ((vc <= (vs+2)) && (hc >= (2+hs))));
  wire 
       b = (vc >= (vs+2)) && (vc <= (14+vs)) && 
((hc <= (15+hs)) && (hc >= (13+hs)));
  wire 
       c = (vc >= (16+vs)) && 
((hc >= (13+hs)) && 
((hc <= (15+hs)) && (vc <= (vs+28))));
  wire 
       d = (hc >= (2+hs)) && (vc >= (vs+28)) && (hc <= (13+hs)) && 
(vc <= (vs+30));
  wire 
       e = (vc >= (16+vs)) && 
((vc <= (vs+28)) && ((hc >= hs) && (hc <= (2+hs))));
  wire 
       f = (vc <= (14+vs)) && (hc >= hs) && 
((hc <= (2+hs)) && (vc >= (vs+2)));
  wire 
       g = (vc <= (16+vs)) && (hc <= (13+hs)) && 
((vc >= (14+vs)) && (hc >= (2+hs)));

  assign yes = (num == 0) ? ((e | (c | d)) | ((a | f) | b)) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? (((a | d) | g) | (e | b)) : 
               (num == 3) ? (((d | g) | b) | (c | a)) : 
               (num == 4) ? (c | ((b | g) | f)) : 
               (num == 5) ? (((a | g) | (d | f)) | c) : 
               (num == 6) ? (((e | c) | (d | g)) | (a | f)) : 
               (num == 7) ? ((a | b) | c) : 
               (num == 8) ? (((b | f) | d) | ((e | a) | (c | g))) : 
               (num == 9) ? (((d | b) | (c | f)) | (a | g)) : 0;
endmodule



module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (vc <= (vs+2)) && (vc >= vs) && 
((hc >= (hs+2)) && (hc <= (13+hs)));
  wire 
       b = (vc >= (vs+2)) && (hc <= (15+hs)) && 
((hc >= (13+hs)) && (vc <= (14+vs)));
  wire 
       c = (vc <= (28+vs)) && 
((hc <= (15+hs)) && (hc >= (13+hs))) && (vc >= (vs+16));
  wire 
       d = (vc <= (30+vs)) && (vc >= (28+vs)) && 
((hc >= (hs+2)) && (hc <= (13+hs)));
  wire 
       e = (vc <= (28+vs)) && 
((hc >= hs) && ((hc <= (hs+2)) && (vc >= (vs+16))));
  wire 
       f = (hc <= (hs+2)) && (vc <= (14+vs)) && 
((vc >= (vs+2)) && (hc >= hs));
  wire 
       g = (vc >= (14+vs)) && (hc >= (hs+2)) && 
((vc <= (vs+16)) && (hc <= (13+hs)));

  assign yes = (num == 0) ? (((f | b) | d) | ((a | c) | e)) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? ((d | a) | (e | (b | g))) : 
               (num == 3) ? (((c | g) | a) | (d | b)) : 
               (num == 4) ? (((b | c) | f) | g) : 
               (num == 5) ? (a | (((c | d) | g) | f)) : 
               (num == 6) ? ((a | g) | ((d | (f | c)) | e)) : 
               (num == 7) ? ((b | c) | a) : 
               (num == 8) ? ((b | (c | d)) | (a | (e | (g | f)))) : 
               (num == 9) ? (((g | d) | b) | ((a | f) | c)) : 0;
endmodule


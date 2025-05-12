
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc >= (2+hs)) && 
((hc <= (hs+13)) && (vc <= (2+vs)) && (vc >= vs));
  wire 
       b = (hc <= (hs+15)) && 
((vc <= (vs+14)) && (vc >= (2+vs)) && (hc >= (hs+13)));
  wire 
       c = (vc >= (16+vs)) && (vc <= (28+vs)) && (hc <= (hs+15)) && 
(hc >= (hs+13));
  wire 
       d = (hc >= (2+hs)) && (hc <= (hs+13)) && 
((vc >= (28+vs)) && (vc <= (30+vs)));
  wire 
       e = (vc >= (16+vs)) && (hc >= hs) && 
((vc <= (28+vs)) && (hc <= (2+hs)));
  wire 
       f = (vc <= (vs+14)) && (hc >= hs) && (hc <= (2+hs)) && 
(vc >= (2+vs));
  wire 
       g = (vc <= (16+vs)) && (hc <= (hs+13)) && 
((hc >= (2+hs)) && (vc >= (vs+14)));

  assign yes = (num == 0) ? ((c | (f | e)) | (d | (a | b))) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? ((a | (g | b)) | (d | e)) : 
               (num == 3) ? (((a | d) | g) | (b | c)) : 
               (num == 4) ? (f | (b | (g | c))) : 
               (num == 5) ? ((((a | d) | g) | f) | c) : 
               (num == 6) ? (((f | d) | (a | c)) | (g | e)) : 
               (num == 7) ? ((a | b) | c) : 
               (num == 8) ? ((((e | c) | g) | (a | b)) | (f | d)) : 
               (num == 9) ? (((g | a) | (b | c)) | (f | d)) : 0;
endmodule


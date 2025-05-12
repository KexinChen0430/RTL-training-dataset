
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc <= (hs+13)) && 
((vc >= vs) && ((vc <= (vs+2)) && (hc >= (hs+2))));
  wire 
       b = (vc >= (vs+2)) && (hc >= (hs+13)) && 
((vc <= (14+vs)) && (hc <= (hs+15)));
  wire 
       c = (hc <= (hs+15)) && 
((vc <= (28+vs)) && (hc >= (hs+13))) && (vc >= (vs+16));
  wire 
       d = (hc >= (hs+2)) && (hc <= (hs+13)) && 
((vc >= (28+vs)) && (vc <= (30+vs)));
  wire 
       e = (vc >= (vs+16)) && 
((hc <= (hs+2)) && ((hc >= hs) && (vc <= (28+vs))));
  wire 
       f = (vc >= (vs+2)) && 
((hc >= hs) && (vc <= (14+vs)) && (hc <= (hs+2)));
  wire 
       g = (vc >= (14+vs)) && (hc >= (hs+2)) && 
((hc <= (hs+13)) && (vc <= (vs+16)));

  assign yes = (num == 0) ? ((c | (f | (a | e))) | (d | b)) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? (((d | e) | g) | (a | b)) : 
               (num == 3) ? ((a | b) | ((d | c) | g)) : 
               (num == 4) ? ((c | g) | (f | b)) : 
               (num == 5) ? (((d | g) | (c | a)) | f) : 
               (num == 6) ? ((((c | g) | a) | e) | (f | d)) : 
               (num == 7) ? (a | (c | b)) : 
               (num == 8) ? ((f | b) | (d | (((c | g) | a) | e))) : 
               (num == 9) ? ((f | c) | ((b | g) | (a | d))) : 0;
endmodule


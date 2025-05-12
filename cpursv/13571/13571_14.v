
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc >= (2+hs)) && (vc <= (2+vs)) && 
((vc >= vs) && (hc <= (hs+13)));
  wire 
       b = (hc <= (15+hs)) && (vc <= (14+vs)) && 
((vc >= (2+vs)) && (hc >= (hs+13)));
  wire 
       c = (vc <= (vs+28)) && (hc <= (15+hs)) && 
((hc >= (hs+13)) && (vc >= (vs+16)));
  wire 
       d = (hc <= (hs+13)) && 
((vc >= (vs+28)) && (hc >= (2+hs)) && (vc <= (vs+30)));
  wire 
       e = (vc <= (vs+28)) && 
((hc <= (2+hs)) && (vc >= (vs+16)) && (hc >= hs));
  wire 
       f = (vc <= (14+vs)) && (hc <= (2+hs)) && (vc >= (2+vs)) && 
(hc >= hs);
  wire 
       g = (vc <= (vs+16)) && 
((hc >= (2+hs)) && (vc >= (14+vs)) && (hc <= (hs+13)));

  assign yes = (num == 0) ? ((a | ((f | e) | c)) | (b | d)) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? (((d | g) | (b | a)) | e) : 
               (num == 3) ? ((a | g) | ((b | d) | c)) : 
               (num == 4) ? (b | ((c | f) | g)) : 
               (num == 5) ? (g | ((c | f) | (d | a))) : 
               (num == 6) ? ((d | f) | ((e | g) | (a | c))) : 
               (num == 7) ? (c | (b | a)) : 
               (num == 8) ? ((g | (b | a)) | (e | ((d | f) | c))) : 
               (num == 9) ? (g | ((c | d) | (f | (b | a)))) : 0;
endmodule


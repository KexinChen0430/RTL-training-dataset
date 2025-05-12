
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc <= (hs+13)) && (vc >= vs) && 
((vc <= (vs+2)) && (hc >= (hs+2)));
  wire 
       b = (vc >= (vs+2)) && (vc <= (vs+14)) && 
((hc <= (15+hs)) && (hc >= (hs+13)));
  wire 
       c = (vc >= (vs+16)) && (hc <= (15+hs)) && 
((vc <= (28+vs)) && (hc >= (hs+13)));
  wire 
       d = (vc >= (28+vs)) && (vc <= (30+vs)) && 
((hc >= (hs+2)) && (hc <= (hs+13)));
  wire 
       e = (hc <= (hs+2)) && (vc >= (vs+16)) && 
((vc <= (28+vs)) && (hc >= hs));
  wire 
       f = (hc <= (hs+2)) && (vc <= (vs+14)) && (hc >= hs) && 
(vc >= (vs+2));
  wire 
       g = (vc >= (vs+14)) && (vc <= (vs+16)) && 
((hc >= (hs+2)) && (hc <= (hs+13)));

  assign yes = (num == 0) ? (a | (d | ((c | b) | (f | e)))) : 
               (num == 1) ? (c | b) : 
               (num == 2) ? (((a | g) | e) | (d | b)) : 
               (num == 3) ? ((a | g) | ((d | c) | b)) : 
               (num == 4) ? (((f | c) | g) | b) : 
               (num == 5) ? (((d | c) | g) | (f | a)) : 
               (num == 6) ? ((e | d) | ((g | f) | (c | a))) : 
               (num == 7) ? ((c | a) | b) : 
               (num == 8) ? (((a | g) | e) | (f | ((d | c) | b))) : 
               (num == 9) ? ((c | ((d | b) | g)) | (f | a)) : 0;
endmodule


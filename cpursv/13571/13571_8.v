
module vga_seg(input  [3:0] num,
               input  [10:0] hc,
               input  [10:0] vc,
               input  [10:0] hs,
               input  [10:0] vs,
               output yes);

  wire 
       a = (hc <= (hs+13)) && (vc >= vs) && 
((vc <= (2+vs)) && (hc >= (hs+2)));
  wire 
       b = (hc <= (hs+15)) && (vc >= (2+vs)) && 
((vc <= (14+vs)) && (hc >= (hs+13)));
  wire 
       c = (vc <= (28+vs)) && (hc >= (hs+13)) && 
((hc <= (hs+15)) && (vc >= (vs+16)));
  wire 
       d = (hc <= (hs+13)) && (hc >= (hs+2)) && 
((vc <= (30+vs)) && (vc >= (28+vs)));
  wire 
       e = (vc <= (28+vs)) && (hc <= (hs+2)) && 
((hc >= hs) && (vc >= (vs+16)));
  wire 
       f = (vc <= (14+vs)) && (vc >= (2+vs)) && 
((hc >= hs) && (hc <= (hs+2)));
  wire 
       g = (vc <= (vs+16)) && 
((vc >= (14+vs)) && ((hc <= (hs+13)) && (hc >= (hs+2))));

  assign yes = (num == 0) ? (((b | (f | c)) | d) | (e | a)) : 
               (num == 1) ? (b | c) : 
               (num == 2) ? (((e | a) | b) | (d | g)) : 
               (num == 3) ? ((b | c) | (a | (d | g))) : 
               (num == 4) ? ((b | (g | f)) | c) : 
               (num == 5) ? ((a | (d | g)) | (f | c)) : 
               (num == 6) ? (d | (e | ((c | (g | a)) | f))) : 
               (num == 7) ? (a | (b | c)) : 
               (num == 8) ? ((a | (d | g)) | ((b | (f | c)) | e)) : 
               (num == 9) ? ((d | f) | ((b | c) | (g | a))) : 0;
endmodule


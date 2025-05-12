module design(
              y10, y11, y12, y13, y14, y15, y16, y17, y18, y19, y20, y21, y22, y23, y24, y25, y26, y27, y30,
              y31, y32, y33, y34, y35, y36, y40, y41, y42, y43, y44, y45,
              i0, i1
              );
   parameter                                             w1 = 2;
   parameter                                             w2 = 4;
   parameter                                             w3 = 256;
   input [w1:0]                                          i0;
   input [w2:0]                                          i1;
   output [w2*w1 :0]                                     y10; 
   output [w2/w1 :0]                                     y11; 
   output [w2+w1 :0]                                     y12; 
   output [w2-w1 :0]                                     y13; 
   output [w2>>w1 :0]                                    y14; 
   output [w2>>>w1:0]                                    y15; 
   output [w2<<w1 :0]                                    y16; 
   output [w2<<<w1:0]                                    y17; 
   output [w2<>>w1:0]                                    y18; 
   output [w2>><w1:0]                                    y19; 
   output [w1*w2/w1+w1 :0]                               y20; 
   output [w2*w1/w1+w1 :0]                               y21; 
   output [w1*w2/(w2-w1)+w1 :0]                          y22; 
   output [w2*w1/(w2-w1)+w2-w1 :0]                       y23; 
   output [w2*w1/(w2-w1)+w1<<1>>1 :0]                    y24; 
   output [w2*w1/(w2-w1)+w1<<w1-w1:0]                    y25; 
   output [(8*4)-1 :0]                                   y26; 
   output [((w3>>3)-1) :0]                               y27; 
   output [w2*w1/w1 +w2+w1 <<w2 >>w1 :0]                 y30; 
   output [w2*w1/w1 +w1+w2 <<w1+w1 >>w2-w1:0]            y31; 
   output [w2*w1/w1 +w1+w2 <<w1+w1 >>w2/w1:0]            y32; 
   output [w1*w2/w1 +w1+w2 <<w2 >>w1 :0]                 y33; 
   output [w1*w2/(w2-w1) +w1+w2 <<w2 >>w1 :0]            y34; 
   output [w1*w2/(w2/w1) +w1+w2 <<w2 >>w2-w1:0]          y35; 
   output [w1*w2/(w1+0) +w1+w2 <<w2 >>w1 :0]             y36; 
   output [w2*w1/w1 +w2*1+w1 <<w2/1 *1 >>w1 *1:0]        y40; 
   output [w2*w1/w1 +w1*1+w2 <<w1/1+w1*1 >>w2-w1*1:0]    y41; 
   output [w2*w1/w1 +w1*1+w2 <<w1/1+w1*1 >>w2/w1*1:0]    y42; 
   output [w1*w2/w1 +w1*1+w2 <<w2/1 *1 >>w1 *1:0]        y43; 
   output [w1*w2/(w2-w1) +w1*1+w2 <<w2/1 *1 >>w1 *1:0]   y44; 
   output [w1*w2/(w2/w1) +w1*1+w2 <<w2/1 *1 >>w2-w1*1:0] y45; 
endmodule
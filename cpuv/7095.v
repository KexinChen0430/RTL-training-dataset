module a_h
  #(parameter M=5, N=3)
   (
    output [N-1:0] [M-1:0] a_o1         
    );
   autoinst_sv_kulkarni_base
     #(
       .M                               (M),
       .N                               (N))
   Ia
     (
      .a_o1                             (a_o1),
      .a_i1                             (a_i1)); 
endmodule
module ack_evict_decode(in0, in1, in2, in3, in4, in5, in6, in7, local, Dinv, Iinv); 
input [127:0] in0; 
input [127:0] in1; 
input [127:0] in2; 
input [127:0] in3; 
input [127:0] in4; 
input [127:0] in5; 
input [127:0] in6; 
input [127:0] in7; 
output [7:0]  local; 
output [7:0]  Dinv; 
output [7:0]  Iinv; 
assign local[0] = (in0[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h0); 
assign Dinv[0]  = in0[0]  | in0[32] | in0[56] | in0[88] ; 
assign Iinv[0]  = in0[1]  | in0[57] ; 
assign local[1] = (in1[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h1);
assign Dinv[1]  = in1[4]  | in1[35] | in1[60] | in1[91] ;
assign Iinv[1]  = in1[5]  | in1[61] ;
assign local[2] = (in2[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h2);
assign Dinv[2]  = in2[8]  | in2[38] | in2[64] | in2[94] ;
assign Iinv[2]  = in2[9]  | in2[65] ;
assign local[3] = (in3[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h3);
assign Dinv[3]  = in3[12] | in3[41] | in3[68] | in3[97] ;
assign Iinv[3]  = in3[13] | in3[69] ;
assign local[4] = (in4[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h4);
assign Dinv[4]  = in4[16] | in4[44]  | in4[72] | in4[100] ;
assign Iinv[4]  = in4[17] | in4[73] ;
assign local[5] = (in5[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h5);
assign Dinv[5]  = in5[20] | in5[47]  | in5[76] | in5[103] ;
assign Iinv[5]  = in5[21] | in5[77] ;
assign local[6] = (in6[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h6);
assign Dinv[6]  = in6[24] | in6[50]  | in6[80] | in6[106] ;
assign Iinv[6]  = in6[25] | in6[81] ;
assign local[7] = (in7[`CPX_CPUID_HI:`CPX_CPUID_LO] == 3'h7);
assign Dinv[7]  = in7[28] | in7[53]  | in7[84] | in7[109] ;
assign Iinv[7]  = in7[29] | in7[85] ;
endmodule 
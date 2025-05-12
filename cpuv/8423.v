module hadamard_trans_1d ( 
    idata_0, 
    idata_1, 
    idata_2, 
    idata_3, 
    idata_4, 
    idata_5, 
    idata_6, 
    idata_7, 
    odata_0, 
    odata_1, 
    odata_2, 
    odata_3, 
    odata_4, 
    odata_5, 
    odata_6, 
    odata_7  
);
parameter DATA_WIDTH = `PIXEL_WIDTH + 1; 
input  signed  [DATA_WIDTH-1         :0] idata_0; 
input  signed  [DATA_WIDTH-1         :0] idata_1; 
input  signed  [DATA_WIDTH-1         :0] idata_2; 
input  signed  [DATA_WIDTH-1         :0] idata_3; 
input  signed  [DATA_WIDTH-1         :0] idata_4; 
input  signed  [DATA_WIDTH-1         :0] idata_5; 
input  signed  [DATA_WIDTH-1         :0] idata_6; 
input  signed  [DATA_WIDTH-1         :0] idata_7; 
output signed  [DATA_WIDTH+2         :0] odata_0; 
output signed  [DATA_WIDTH+2         :0] odata_1; 
output signed  [DATA_WIDTH+2         :0] odata_2; 
output signed  [DATA_WIDTH+2         :0] odata_3; 
output signed  [DATA_WIDTH+2         :0] odata_4; 
output signed  [DATA_WIDTH+2         :0] odata_5; 
output signed  [DATA_WIDTH+2         :0] odata_6; 
output signed  [DATA_WIDTH+2         :0] odata_7; 
wire   signed  [DATA_WIDTH           :0] m1_0; 
wire   signed  [DATA_WIDTH           :0] m1_1; 
wire   signed  [DATA_WIDTH           :0] m1_2; 
wire   signed  [DATA_WIDTH           :0] m1_3; 
wire   signed  [DATA_WIDTH           :0] m1_4; 
wire   signed  [DATA_WIDTH           :0] m1_5; 
wire   signed  [DATA_WIDTH           :0] m1_6; 
wire   signed  [DATA_WIDTH           :0] m1_7; 
wire   signed  [DATA_WIDTH+1         :0] m2_0; 
wire   signed  [DATA_WIDTH+1         :0] m2_1; 
wire   signed  [DATA_WIDTH+1         :0] m2_2; 
wire   signed  [DATA_WIDTH+1         :0] m2_3; 
wire   signed  [DATA_WIDTH+1         :0] m2_4; 
wire   signed  [DATA_WIDTH+1         :0] m2_5; 
wire   signed  [DATA_WIDTH+1         :0] m2_6; 
wire   signed  [DATA_WIDTH+1         :0] m2_7; 
assign m1_0    = {idata_0[DATA_WIDTH-1],idata_0} + {idata_4[DATA_WIDTH-1],idata_4}; 
assign m1_1    = {idata_1[DATA_WIDTH-1],idata_1} + {idata_5[DATA_WIDTH-1],idata_5}; 
assign m1_2    = {idata_2[DATA_WIDTH-1],idata_2} + {idata_6[DATA_WIDTH-1],idata_6}; 
assign m1_3    = {idata_3[DATA_WIDTH-1],idata_3} + {idata_7[DATA_WIDTH-1],idata_7}; 
assign m1_4    = {idata_0[DATA_WIDTH-1],idata_0} - {idata_4[DATA_WIDTH-1],idata_4}; 
assign m1_5    = {idata_1[DATA_WIDTH-1],idata_1} - {idata_5[DATA_WIDTH-1],idata_5}; 
assign m1_6    = {idata_2[DATA_WIDTH-1],idata_2} - {idata_6[DATA_WIDTH-1],idata_6}; 
assign m1_7    = {idata_3[DATA_WIDTH-1],idata_3} - {idata_7[DATA_WIDTH-1],idata_7}; 
assign m2_0    = {m1_0[DATA_WIDTH],m1_0}         + {m1_2[DATA_WIDTH],m1_2}; 
assign m2_1    = {m1_1[DATA_WIDTH],m1_1}         + {m1_3[DATA_WIDTH],m1_3}; 
assign m2_2    = {m1_0[DATA_WIDTH],m1_0}         - {m1_2[DATA_WIDTH],m1_2}; 
assign m2_3    = {m1_1[DATA_WIDTH],m1_1}         - {m1_3[DATA_WIDTH],m1_3}; 
assign m2_4    = {m1_4[DATA_WIDTH],m1_4}         + {m1_6[DATA_WIDTH],m1_6}; 
assign m2_5    = {m1_5[DATA_WIDTH],m1_5}         + {m1_7[DATA_WIDTH],m1_7}; 
assign m2_6    = {m1_4[DATA_WIDTH],m1_4}         - {m1_6[DATA_WIDTH],m1_6}; 
assign m2_7    = {m1_5[DATA_WIDTH],m1_5}         - {m1_7[DATA_WIDTH],m1_7}; 
assign odata_0 = {m2_0[DATA_WIDTH+1],m2_0}       + {m2_1[DATA_WIDTH+1],m2_1}; 
assign odata_1 = {m2_0[DATA_WIDTH+1],m2_0}       - {m2_1[DATA_WIDTH+1],m2_1}; 
assign odata_2 = {m2_2[DATA_WIDTH+1],m2_2}       + {m2_3[DATA_WIDTH+1],m2_3}; 
assign odata_3 = {m2_2[DATA_WIDTH+1],m2_2}       - {m2_3[DATA_WIDTH+1],m2_3}; 
assign odata_4 = {m2_4[DATA_WIDTH+1],m2_4}       + {m2_5[DATA_WIDTH+1],m2_5}; 
assign odata_5 = {m2_4[DATA_WIDTH+1],m2_4}       - {m2_5[DATA_WIDTH+1],m2_5}; 
assign odata_6 = {m2_6[DATA_WIDTH+1],m2_6}       + {m2_7[DATA_WIDTH+1],m2_7}; 
assign odata_7 = {m2_6[DATA_WIDTH+1],m2_6}       - {m2_7[DATA_WIDTH+1],m2_7}; 
endmodule 
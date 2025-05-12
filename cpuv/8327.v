module BUFHCE_VPR 
(
output O, 
input I, 
input CE 
);
  parameter [0:0] INIT_OUT = 1'b0; 
  parameter CE_TYPE = "SYNC"; 
  parameter [0:0] ZINV_CE = 1'b0; 
  wire I = ((CE ^ !ZINV_CE) ? I : INIT_OUT); 
  assign O = I; 
endmodule 
module MAC1
  (
   input CLK,             
   input ARST,            
   input signed [IWIDTH-1:0] filterCoef, 
   input signed [IWIDTH-1:0] InData,     
   input input_Valid,     
   input initialize,      
   output signed [OWIDTH-1:0] OutData,   
   output output_Valid    
   );
   parameter IWIDTH = 16;  
   parameter OWIDTH = 32;  
   parameter AWIDTH = 32;  
   parameter NTAPS = 15;   
   parameter NTAPSr = 15;  
   parameter CNTWIDTH = 4; 
   parameter NMULT = 1;    
   reg signed [AWIDTH-1:0] mult, accum; 
   reg input_Valid0;                     
   reg initialize1;                      
   reg output_Valid_1;                   
   wire output_Valid;                    
   reg [CNTWIDTH-1:0] count;             
   wire signed [AWIDTH-1:0] accum_tmp;   
   wire [CNTWIDTH-1:0] taps;             
   assign taps = (NTAPS == NTAPSr) ? 0 : (NTAPS - NTAPS + NTAPSr);
   always @(posedge CLK or posedge ARST)
     if (ARST) input_Valid0 <= 1'b0;
     else input_Valid0 <= input_Valid;
   always @(posedge CLK or posedge ARST)
     if (ARST) initialize1 <= 1'b0;
     else initialize1 <= initialize;
   always @(posedge CLK or posedge ARST)
     if (ARST) mult <= 0;
     else mult <= filterCoef * InData;
   assign accum_tmp = mult + accum;
   always @(posedge CLK or posedge ARST)
     if (ARST) accum <= 0;
     else accum <= (initialize1) ? mult : (input_Valid0 ? accum_tmp : accum);
   always @(posedge CLK or posedge ARST)
     if (ARST) count <= 0;
     else count <= initialize ? 0 : input_Valid0 + count;
   always @(posedge CLK or posedge ARST)
     if (ARST) output_Valid_1 <= 1'b0;
     else output_Valid_1 <= (count == (NTAPSr-1+NMULT-1));
   assign output_Valid = output_Valid_1 & (count == taps);
   assign OutData = accum;
endmodule
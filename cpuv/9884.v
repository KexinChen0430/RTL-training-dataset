module ISERDESE2 ( 
   input  CLKDIVP,        
   input  D,              
   input  DDLY,           
   input  DYNCLKDIVSEL,   
   input  DYNCLKSEL,      
   input  OCLK,           
   input  OCLKB,          
   input  OFB,            
   input  RST,            
   input  SHIFTIN1,       
   input  SHIFTIN2,       
   output O,              
   output Q1,             
   output Q2,
   output Q3,
   output Q4,
   output Q5,
   output Q6,
   output Q7,
   output Q8,             
   output SHIFTOUT1,      
   output SHIFTOUT2       
);
reg [3:0] even_samples;
reg [3:0] odd_samples;
always @ (posedge CLK)
  even_samples[3:0] <= {even_samples[2:0],D};
always @ (negedge CLK)
  odd_samples[3:0] <= {odd_samples[2:0],D};
assign Q1 = odd_samples[0];
assign Q2 = even_samples[0];
assign Q3 = odd_samples[1];
assign Q4 = even_samples[1];
assign Q5 = odd_samples[2];
assign Q6 = even_samples[2];
assign Q7 = odd_samples[3];
assign Q8 = even_samples[3];
assign O = D;
assign SHIFTOUT1 = 1'b0;
assign SHIFTOUT2 = 1'b0;
endmodule 
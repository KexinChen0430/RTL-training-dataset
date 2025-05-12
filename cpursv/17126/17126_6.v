
module dpram32  #(parameter  AWIDTH = 15, RAM_SIZE = 16384)
  (input  clk,
   input  [AWIDTH+(0-1):0] adr1_i,
   input  [31:0] dat1_i,
   output reg [31:0] dat1_o,
   input  we1_i,
   input  en1_i,
   input  [3:0] sel1_i,
   input  [AWIDTH+(0-1):0] adr2_i,
   input  [31:0] dat2_i,
   output reg [31:0] dat2_o,
   input  we2_i,
   input  en2_i,
   input  [3:0] sel2_i);

  reg  [7:0] ram0[0:(0-1)+(RAM_SIZE*(1/4))];
  reg  [7:0] ram1[0:(0-1)+(RAM_SIZE*(1/4))];
  reg  [7:0] ram2[0:(0-1)+(RAM_SIZE*(1/4))];
  reg  [7:0] ram3[0:(0-1)+(RAM_SIZE*(1/4))];

  
  always @(posedge clk)
      if (en1_i) dat1_o[31:24] <= ram3[adr1_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if (en1_i) dat1_o[23:16] <= ram2[adr1_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if (en1_i) dat1_o[15:8] <= ram1[adr1_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if (en1_i) dat1_o[7:0] <= ram0[adr1_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if (we1_i & (en1_i & sel1_i[3])) ram3[adr1_i[AWIDTH+(0-1):1+1]] <= dat1_i[31:24];
        
  
  always @(posedge clk)
      if (en1_i & (sel1_i[1+1] & we1_i)) ram2[adr1_i[AWIDTH+(0-1):1+1]] <= dat1_i[23:16];
        
  
  always @(posedge clk)
      if (sel1_i[1] & (en1_i & we1_i)) ram1[adr1_i[AWIDTH+(0-1):1+1]] <= dat1_i[15:8];
        
  
  always @(posedge clk)
      if ((sel1_i[0] & we1_i) & en1_i) ram0[adr1_i[AWIDTH+(0-1):1+1]] <= dat1_i[7:0];
        
  
  always @(posedge clk)
      if (en2_i) dat2_o[31:24] <= ram3[adr2_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if (en2_i) dat2_o[23:16] <= ram2[adr2_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if (en2_i) dat2_o[15:8] <= ram1[adr2_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if (en2_i) dat2_o[7:0] <= ram0[adr2_i[AWIDTH+(0-1):1+1]];
        
  
  always @(posedge clk)
      if ((en2_i & we2_i) & sel2_i[3]) ram3[adr2_i[AWIDTH+(0-1):1+1]] <= dat2_i[31:24];
        
  
  always @(posedge clk)
      if ((en2_i & we2_i) & sel2_i[1+1]) ram2[adr2_i[AWIDTH+(0-1):1+1]] <= dat2_i[23:16];
        
  
  always @(posedge clk)
      if ((en2_i & we2_i) & sel2_i[1]) ram1[adr2_i[AWIDTH+(0-1):1+1]] <= dat2_i[15:8];
        
  
  always @(posedge clk)
      if ((en2_i & we2_i) & sel2_i[0]) ram0[adr2_i[AWIDTH+(0-1):1+1]] <= dat2_i[7:0];
        
endmodule


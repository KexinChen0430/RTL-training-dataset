
module NIOS_Sys_altpll_0_dffpipe_l2c(clock,clrn,d,q);

  input  clock;
  input  clrn;
  input  d;
  output q;
  tri0 clock;
  tri1 clrn;
  reg  dffe4a;
  reg  dffe5a;
  reg  dffe6a;
  wire ena;
  wire prn;
  wire sclr;

  
  initial    dffe4a = 0;
  
  always @(posedge clock or negedge prn or negedge clrn)
      if (prn == 1'b0) dffe4a <= {1{1'b1}};
      else if (clrn == 1'b0) dffe4a <= 1'b0;
      else if (ena == 1'b1) dffe4a <= d & ~sclr;
        
  
  initial    dffe5a = 0;
  
  always @(posedge clock or negedge prn or negedge clrn)
      if (prn == 1'b0) dffe5a <= {1{1'b1}};
      else if (clrn == 1'b0) dffe5a <= 1'b0;
      else if (ena == 1'b1) dffe5a <= dffe4a & ~sclr;
        
  
  initial    dffe6a = 0;
  
  always @(posedge clock or negedge prn or negedge clrn)
      if (prn == 1'b0) dffe6a <= {1{1'b1}};
      else if (clrn == 1'b0) dffe6a <= 1'b0;
      else if (ena == 1'b1) dffe6a <= dffe5a & ~sclr;
        
  assign ena = 1'b1,
         prn = 1'b1,
         q = dffe6a,
         sclr = 1'b0;
endmodule


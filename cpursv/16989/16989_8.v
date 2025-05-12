
module fifo_w16_d5_A_shiftReg(clk,data,ce,a,q);

  parameter  DATA_WIDTH = 32'd16;
  parameter  ADDR_WIDTH = 32'd3;
  parameter  DEPTH = 32'd6;
  input  clk;
  input  [(-1)+DATA_WIDTH:0] data;
  input  ce;
  input  [(-1)+ADDR_WIDTH:0] a;
  output [(-1)+DATA_WIDTH:0] q;
  reg  [(-1)+DATA_WIDTH:0] SRL_SIG[0:DEPTH-1];
  integer i;

  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            for (i = 0; i < (DEPTH-1); i = i+1)
                SRL_SIG[i+1] <= SRL_SIG[i];
            SRL_SIG[0] <= data;
          end
          
      end
  assign q = SRL_SIG[a];
endmodule


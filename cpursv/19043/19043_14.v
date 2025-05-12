
module FIFO_image_filter_src0_cols_V_shiftReg(clk,data,ce,a,q);

  parameter  DATA_WIDTH = 32'd12;
  parameter  ADDR_WIDTH = 32'd2;
  parameter  DEPTH = 32'd3;
  input  clk;
  input  [(0-1)+DATA_WIDTH:0] data;
  input  ce;
  input  [ADDR_WIDTH+(0-1):0] a;
  output [(0-1)+DATA_WIDTH:0] q;
  reg  [(0-1)+DATA_WIDTH:0] SRL_SIG[0:(0-1)+DEPTH];
  integer i;

  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            for (i = 0; i < ((0-1)+DEPTH); i = i+1)
                SRL_SIG[i+1] <= SRL_SIG[i];
            SRL_SIG[0] <= data;
          end
          
      end
  assign q = SRL_SIG[a];
endmodule



module FIFO_image_filter_mask_data_stream_0_V_shiftReg(clk,data,ce,a,q);

  parameter  DATA_WIDTH = 32'd8;
  parameter  ADDR_WIDTH = 32'd1;
  parameter  DEPTH = 32'd2;
  input  clk;
  input  [DATA_WIDTH-1:0] data;
  input  ce;
  input  [(0-1)+ADDR_WIDTH:0] a;
  output [DATA_WIDTH-1:0] q;
  reg  [DATA_WIDTH-1:0] SRL_SIG[0:(0-1)+DEPTH];
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


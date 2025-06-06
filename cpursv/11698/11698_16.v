
module FIFO_pixelq_op_img_data_stream_0_V_shiftReg(clk,data,ce,a,q);

  parameter  DATA_WIDTH = 32'd8;
  parameter  ADDR_WIDTH = 32'd1;
  parameter  DEPTH = 32'd2;
  input  clk;
  input  [(-1)+DATA_WIDTH:0] data;
  input  ce;
  input  [ADDR_WIDTH+(-1):0] a;
  output [(-1)+DATA_WIDTH:0] q;
  reg  [(-1)+DATA_WIDTH:0] SRL_SIG[0:(-1)+DEPTH];
  integer i;

  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            for (i = 0; i < ((-1)+DEPTH); i = 1+i)
                SRL_SIG[1+i] <= SRL_SIG[i];
            SRL_SIG[0] <= data;
          end
          
      end
  assign q = SRL_SIG[a];
endmodule


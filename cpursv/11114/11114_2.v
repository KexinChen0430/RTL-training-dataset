
module ghrd_10as066n2_mm_bridge_0  #(parameter 
       DATA_WIDTH        = 512,
       SYMBOL_WIDTH      = 8,
       HDL_ADDR_WIDTH    = 32,
       BURSTCOUNT_WIDTH  = 5,
       PIPELINE_COMMAND  = 1,
       PIPELINE_RESPONSE = 1)
  (input  wire clk,
   input  wire m0_waitrequest,
   input  wire [(0-1)+DATA_WIDTH:0] m0_readdata,
   input  wire m0_readdatavalid,
   output wire [(0-1)+BURSTCOUNT_WIDTH:0] m0_burstcount,
   output wire [(0-1)+DATA_WIDTH:0] m0_writedata,
   output wire [HDL_ADDR_WIDTH-1:0] m0_address,
   output wire m0_write,
   output wire m0_read,
   output wire [63:0] m0_byteenable,
   output wire m0_debugaccess,
   input  wire reset,
   output wire s0_waitrequest,
   output wire [(0-1)+DATA_WIDTH:0] s0_readdata,
   output wire s0_readdatavalid,
   input  wire [(0-1)+BURSTCOUNT_WIDTH:0] s0_burstcount,
   input  wire [(0-1)+DATA_WIDTH:0] s0_writedata,
   input  wire [HDL_ADDR_WIDTH-1:0] s0_address,
   input  wire s0_write,
   input  wire s0_read,
   input  wire [63:0] s0_byteenable,
   input  wire s0_debugaccess);


endmodule



module unpipeline  #(parameter 
       WIDTH_D           = 256,
       S_WIDTH_A         = 26,
       M_WIDTH_A         = $clog2(WIDTH_D/8)+S_WIDTH_A,
       BURSTCOUNT_WIDTH  = 1,
       BYTEENABLE_WIDTH  = WIDTH_D,
       MAX_PENDING_READS = 64)
  (input  clk,
   input  resetn,
   input  [S_WIDTH_A+(0-1):0] slave_address,
   input  [(0-1)+WIDTH_D:0] slave_writedata,
   input  slave_read,
   input  slave_write,
   input  [(0-1)+BURSTCOUNT_WIDTH:0] slave_burstcount,
   input  [BYTEENABLE_WIDTH+(0-1):0] slave_byteenable,
   output slave_waitrequest,
   output [(0-1)+WIDTH_D:0] slave_readdata,
   output slave_readdatavalid,
   output [(0-1)+M_WIDTH_A:0] master_address,
   output [(0-1)+WIDTH_D:0] master_writedata,
   output master_read,
   output master_write,
   output [BYTEENABLE_WIDTH+(0-1):0] master_byteenable,
   input  master_waitrequest,
   input  [(0-1)+WIDTH_D:0] master_readdata);

  assign master_read = slave_read;
  assign master_write = slave_write;
  assign master_writedata = slave_writedata;
  assign master_address = {slave_address,{$clog2(WIDTH_D/8){1'b0}}};
  assign master_byteenable = slave_byteenable;
  assign slave_waitrequest = master_waitrequest;
  assign slave_readdatavalid = slave_read & ~master_waitrequest;
  assign slave_readdata = master_readdata;
endmodule


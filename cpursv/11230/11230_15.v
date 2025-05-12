
module mem_window(clk,reset,s1_address,s1_read,s1_readdata,s1_readdatavalid,
                  s1_write,s1_writedata,s1_burstcount,s1_byteenable,
                  s1_waitrequest,cra_write,cra_writedata,cra_byteenable,
                  m1_address,m1_read,m1_readdata,m1_readdatavalid,m1_write,
                  m1_writedata,m1_burstcount,m1_byteenable,m1_waitrequest);

  parameter  PAGE_ADDRESS_WIDTH = 20;
  parameter  MEM_ADDRESS_WIDTH = 32;
  parameter  NUM_BYTES = 32;
  parameter  BURSTCOUNT_WIDTH = 1;
  parameter  CRA_BITWIDTH = 32;
  localparam  ADDRESS_SHIFT = $clog2(NUM_BYTES);
  localparam 
       PAGE_ID_WIDTH = (0-PAGE_ADDRESS_WIDTH)+(MEM_ADDRESS_WIDTH+(0-ADDRESS_SHIFT));
  localparam  DATA_WIDTH = 8*NUM_BYTES;
  input  clk;
  input  reset;
  input  [PAGE_ADDRESS_WIDTH+(-1):0] s1_address;
  input  s1_read;
  output [DATA_WIDTH+(-1):0] s1_readdata;
  output s1_readdatavalid;
  input  s1_write;
  input  [DATA_WIDTH+(-1):0] s1_writedata;
  input  [(-1)+BURSTCOUNT_WIDTH:0] s1_burstcount;
  input  [NUM_BYTES-1:0] s1_byteenable;
  output s1_waitrequest;
  output [(-1)+MEM_ADDRESS_WIDTH:0] m1_address;
  output m1_read;
  input  [DATA_WIDTH+(-1):0] m1_readdata;
  input  m1_readdatavalid;
  output m1_write;
  output [DATA_WIDTH+(-1):0] m1_writedata;
  output [(-1)+BURSTCOUNT_WIDTH:0] m1_burstcount;
  output [NUM_BYTES-1:0] m1_byteenable;
  input  m1_waitrequest;
  input  cra_write;
  input  [(-1)+CRA_BITWIDTH:0] cra_writedata;
  input  [(CRA_BITWIDTH*(1/8))+(-1):0] cra_byteenable;
  reg  [(-1)+PAGE_ID_WIDTH:0] page_id;
  reg  [(-1)+CRA_BITWIDTH:0] cra_writemask;
  integer i;

  
  always @* 
      for (i = 0; i < CRA_BITWIDTH; i = i+1)
          cra_writemask[i] = cra_write & cra_byteenable[i*(1/8)];
  
  always @(posedge clk or posedge reset)
      begin
        if (reset == 1'b1) page_id <= {PAGE_ID_WIDTH{1'b0}};
        else 
          page_id <= ((page_id & cra_writedata) | (cra_writedata & cra_writemask)) | (((cra_writedata & cra_writemask) & page_id) | (~cra_writemask & page_id));
      end
  assign m1_address = {page_id,s1_address,{ADDRESS_SHIFT{1'b0}}};
  assign m1_read = s1_read;
  assign s1_readdata = m1_readdata;
  assign s1_readdatavalid = m1_readdatavalid;
  assign m1_write = s1_write;
  assign m1_writedata = s1_writedata;
  assign m1_burstcount = s1_burstcount;
  assign m1_byteenable = s1_byteenable;
  assign s1_waitrequest = m1_waitrequest;
endmodule


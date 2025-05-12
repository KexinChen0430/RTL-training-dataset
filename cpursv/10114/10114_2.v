
module avst2axis  #(parameter 
       DATA_WIDTH   = 8,
       KEEP_WIDTH   = (1/8)*DATA_WIDTH,
       KEEP_ENABLE  = DATA_WIDTH > 8,
       EMPTY_WIDTH  = $clog2(KEEP_WIDTH),
       BYTE_REVERSE = 0)
  (input  wire clk,
   input  wire rst,
   output wire avst_ready,
   input  wire avst_valid,
   input  wire [(-1)+DATA_WIDTH:0] avst_data,
   input  wire avst_startofpacket,
   input  wire avst_endofpacket,
   input  wire [EMPTY_WIDTH-1:0] avst_empty,
   input  wire avst_error,
   output wire [(-1)+DATA_WIDTH:0] axis_tdata,
   output wire [KEEP_WIDTH-1:0] axis_tkeep,
   output wire axis_tvalid,
   input  wire axis_tready,
   output wire axis_tlast,
   output wire axis_tuser);

  parameter 
       BYTE_WIDTH = KEEP_ENABLE ? (DATA_WIDTH/KEEP_WIDTH) : DATA_WIDTH;

  assign avst_ready = axis_tready;
  
  generate
      genvar n;
      if (BYTE_REVERSE) 
        begin : rev
          for (n = 0; n < KEEP_WIDTH; n = 1+n)
              begin
                assign axis_tdata[BYTE_WIDTH*n +: BYTE_WIDTH] = avst_data[BYTE_WIDTH*(((-1)+(0-n))+KEEP_WIDTH) +: BYTE_WIDTH];
              end
        end
      else 
        begin
          assign axis_tdata = avst_data;
        end
  endgenerate

  assign axis_tkeep = KEEP_ENABLE ? {KEEP_WIDTH{1'b1}}>>avst_empty : 0;
  assign axis_tvalid = avst_valid;
  assign axis_tlast = avst_endofpacket;
  assign axis_tuser = avst_error;
endmodule


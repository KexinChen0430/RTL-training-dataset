
module cdc_fifomem  #(parameter  DATASIZE = 34, ADDRSIZE = 1<<<1)
  (output wire [(-1)+DATASIZE:0] rdata,
   input  wire [(-1)+DATASIZE:0] wdata,
   input  wire [(-1)+ADDRSIZE:0] waddr,raddr,
   input  wire wclken,wfull,wclk);

  localparam  DEPTH = 1<<ADDRSIZE;
  reg  [(-1)+DATASIZE:0] cdc_mem[0:DEPTH-1];

  assign rdata = cdc_mem[raddr];
  
  always @(posedge wclk)
      if (wclken && !wfull) cdc_mem[waddr] <= wdata;
        
endmodule


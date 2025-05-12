
module cdc_fifomem  #(parameter  DATASIZE = 34, ADDRSIZE = 2)
  (output wire [(-1)+DATASIZE:0] rdata,
   input  wire [(-1)+DATASIZE:0] wdata,
   input  wire [ADDRSIZE+(-1):0] waddr,raddr,
   input  wire wclken,wfull,wclk);

  localparam  DEPTH = 1<<ADDRSIZE;
  reg  [(-1)+DATASIZE:0] cdc_mem[0:(-1)+DEPTH];

  assign rdata = cdc_mem[raddr];
  
  always @(posedge wclk)
      if (!wfull && wclken) cdc_mem[waddr] <= wdata;
        
endmodule



module cdc_fifomem  #(parameter  DATASIZE = 34, ADDRSIZE = 1+1)
  (output wire [DATASIZE+(0-1):0] rdata,
   input  wire [DATASIZE+(0-1):0] wdata,
   input  wire [ADDRSIZE+(0-1):0] waddr,raddr,
   input  wire wclken,wfull,wclk);

  localparam  DEPTH = 1<<ADDRSIZE;
  reg  [DATASIZE+(0-1):0] cdc_mem[0:DEPTH-1];

  assign rdata = cdc_mem[raddr];
  
  always @(posedge wclk)
      if (wclken && !wfull) cdc_mem[waddr] <= wdata;
        
endmodule


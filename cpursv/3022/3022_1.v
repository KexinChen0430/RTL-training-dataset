
module openhmc_ram  #(parameter  DATASIZE = 78, ADDRSIZE = 9, PIPELINED = 0)
  (input  wire clk,
   input  wire wen,
   input  wire [(-1)+DATASIZE:0] wdata,
   input  wire [(-1)+ADDRSIZE:0] waddr,
   input  wire ren,
   input  wire [(-1)+ADDRSIZE:0] raddr,
   output wire [(-1)+DATASIZE:0] rdata);

  wire [(-1)+DATASIZE:0] rdata_ram;

  
  generate
      if (PIPELINED == 0) 
        begin
          assign rdata = rdata_ram;
        end
      else 
        begin
          reg  [(-1)+DATASIZE:0] rdata_dly;

          reg  ren_dly;

          assign rdata = rdata_dly;
          
          always @(posedge clk)
              begin
                ren_dly <= ren;
                if (ren_dly) rdata_dly <= rdata_ram;
                  
              end
        end
  endgenerate

  reg  [(-1)+DATASIZE:0] MEM[0:(2**ADDRSIZE)+(-1)];

  reg  [(-1)+DATASIZE:0] data_out;

  assign rdata_ram = data_out;
  
  always @(posedge clk)
      begin
        if (wen) MEM[waddr] <= wdata;
          
      end
  
  always @(posedge clk)
      begin
        if (ren) data_out <= MEM[raddr];
          
      end
endmodule


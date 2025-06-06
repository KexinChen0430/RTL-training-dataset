
module gpio(input  wire clk,
            input  wire resetn,
            input  wire enable,
            input  wire mem_valid,
            output wire mem_ready,
            input  wire mem_instr,
            input  wire [3:0] mem_wstrb,
            input  wire [31:0] mem_wdata,
            input  wire [31:0] mem_addr,
            output wire [31:0] mem_rdata,
            output reg [31:0] gpio);

  reg  [7:0] q;
  reg  rdy;

  
  always @(posedge clk)
      begin
        if (!resetn) 
          begin
            rdy <= 0;
            q <= 0;
            gpio <= 0;
          end
        else if (enable & mem_valid) 
          begin
            if (mem_wstrb[0]) gpio[7:0] <= mem_wdata[7:0];
              
            if (mem_wstrb[1]) gpio[15:8] <= mem_wdata[15:8];
              
            if (mem_wstrb[2]) gpio[23:16] <= mem_wdata[23:16];
              
            if (mem_wstrb[3]) gpio[31:24] <= mem_wdata[31:24];
              
            rdy <= 1;
          end
        else 
          begin
            rdy <= 0;
          end
        q <= gpio;
      end
  assign mem_rdata = enable ? q : 1'b0;
  assign mem_ready = enable ? rdy : 1'b0;
endmodule


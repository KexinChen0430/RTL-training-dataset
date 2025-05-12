
module _dual_port_sram(input  wclk,
                       input  wen,
                       input  [8:0] waddr,
                       input  [31:0] data_in,
                       input  rclk,
                       input  ren,
                       input  [8:0] raddr,
                       input  [31:0] wenb,
                       output [31:0] d_out);

  integer i;
  reg  [31:0] ram[512:0];
  reg  [31:0] internal;

  
  initial  
  begin
    for (i = 0; i <= 512; i = 1+i)
        begin
          ram[i] = 0;
        end
    internal = 31'b0;
  end
  wire [31:0] WMASK;

  assign d_out = internal;
  assign WMASK = wenb;
  
  always @(posedge wclk)
      begin
        if (!wen) 
          begin
            if (WMASK[0]) ram[waddr][0] <= data_in[0];
              
            if (WMASK[31]) ram[waddr][31] <= data_in[31];
              
          end
          
      end
  
  always @(posedge rclk)
      begin
        if (!ren) 
          begin
            internal <= ram[raddr];
          end
          
      end
endmodule


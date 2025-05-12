
module simple_dual_ram_47  #(parameter  SIZE = 8, DEPTH = 8)
  (input  wclk,
   input  [$clog2(DEPTH)+(0-1):0] waddr,
   input  [(0-1)+SIZE:0] write_data,
   input  write_en,
   input  rclk,
   input  [$clog2(DEPTH)+(0-1):0] raddr,
   output reg [(0-1)+SIZE:0] read_data);

  reg  [(0-1)+SIZE:0] mem[DEPTH+(0-1):0];

  
  always @(posedge wclk)
      begin
        if (write_en) mem[waddr] <= write_data;
          
      end
  
  always @(posedge rclk)
      begin
        read_data <= mem[raddr];
      end
endmodule


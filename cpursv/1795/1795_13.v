
module ioport(input  wire clk,
              input  wire [7:0] external_in,
              output reg [7:0] external_out,
              input  wire [m-1:0] addr,
              input  wire rd_strobe,
              input  wire wr_strobe,
              input  wire [(-1)+n:0] wr_data,
              input  wire [(n/8)+(-1):0] wr_byteena,
              output wire hold,
              output reg rd_data);

  assign hold = 0;
  
  always @(posedge clk)
      begin
        rd_data <= rd_strobe ? external_in : 0;
        if (wr_byteena & wr_strobe) external_out <= wr_data;
          
      end
endmodule


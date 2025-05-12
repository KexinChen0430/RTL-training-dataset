
module BRAM_sp(clk,we,en,addr,data_in,data_out);

  parameter  WIDTH = 8, DEPTH = 1024, DEPTH_LOG = 10;
  input  wire clk;
  input  wire we;
  input  wire en;
  input  wire [DEPTH_LOG-1:0] addr;
  input  wire [(-1)+WIDTH:0] data_in;
  output reg [(-1)+WIDTH:0] data_out;
  reg  [(-1)+WIDTH:0] data[0:(-1)+DEPTH];

  
  always @(posedge clk)
      begin
        if (en) 
          begin
            if (we) 
              begin
                data[addr] <= data_in;
              end
            else 
              begin
                data_out <= data[addr];
              end
          end
          
      end
endmodule


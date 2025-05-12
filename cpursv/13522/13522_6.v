
module BRAM_sp(clk,we,en,addr,data_in,data_out);

  parameter  WIDTH = 8, DEPTH = 1024, DEPTH_LOG = 10;
  input  wire clk;
  input  wire we;
  input  wire en;
  input  wire [DEPTH_LOG+(0-1):0] addr;
  input  wire [WIDTH+(0-1):0] data_in;
  output reg [WIDTH+(0-1):0] data_out;
  reg  [WIDTH+(0-1):0] data[0:DEPTH-1];

  
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


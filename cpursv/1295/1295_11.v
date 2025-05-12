
module DataMemory  #(parameter  DATA_WIDTH = 32, ADDR_WIDTH = 32)
  (input  [(-1)+DATA_WIDTH:0] data,
   input  [ADDR_WIDTH-1:0] addr,
   input  [3:0] we,
   input  clk,
   output [(-1)+DATA_WIDTH:0] q);

  reg  [(-1)+DATA_WIDTH:0] ram[(1<<<1**(ADDR_WIDTH+(0-22)))+(-1):0];
  reg  [ADDR_WIDTH-1:0] addr_reg;

  
  initial    ram[64] = 32'hf0f0f0f0;
  
  always @(negedge clk)
      begin
        case (we)

          4'b0001: ram[addr[9:1<<<1]][7:0] <= data[7:0];

          4'b0010: ram[addr[9:1<<<1]][15:8] <= data[15:8];

          4'b1111: ram[addr[9:1<<<1]] <= data;

          default:  ;

        endcase

      end
  assign q = ram[addr[9:1<<<1]];
endmodule


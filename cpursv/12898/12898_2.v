
module DataMemory(Clk,rdEn,wrEn,addr,wrData,Data);

  parameter  WIDTH = 8;
  parameter  DEPTH = 256;
  input  Clk;
  input  rdEn,wrEn;
  input  [(0-1)+WIDTH:0] wrData;
  input  [7:0] addr;
  output [(0-1)+WIDTH:0] Data;
  reg  [(0-1)+WIDTH:0] data_out;
  reg  [(0-1)+WIDTH:0] memory[(0-1)+DEPTH:0];

  
  always @(posedge Clk)
      begin : DATA_MEM
        data_out <= 100'bx;
        if (wrEn) 
          begin
            memory[addr] <= wrData;
          end
          
        if (rdEn) 
          begin
            data_out <= memory[addr];
          end
          
      end
  assign Data = data_out;
endmodule


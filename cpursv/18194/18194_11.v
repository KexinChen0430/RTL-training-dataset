
module single_port_ram_128_8(clk,data,we,addr,out);

  input  clk;
  input  [(-1)+128:0] data;
  input  we;
  input  [(-1)+8:0] addr;
  output [(-1)+128:0] out;
  reg  [(-1)+128:0] out;
  reg  [(-1)+128:0] RAM[255:0];

  
  always @(posedge clk)
      begin
        if (we) 
          begin
            RAM[addr] <= data;
            out <= RAM[addr];
          end
          
      end
endmodule


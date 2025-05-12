
module single_port_ram_21_8(clk,data,we,addr,out);

  input  clk;
  input  [21-1:0] data;
  input  we;
  input  [8-1:0] addr;
  output [21-1:0] out;
  reg  [21-1:0] out;
  reg  [21-1:0] RAM[255:0];

  
  always @(posedge clk)
      begin
        if (we) 
          begin
            RAM[addr] <= data;
            out <= RAM[addr];
          end
          
      end
endmodule


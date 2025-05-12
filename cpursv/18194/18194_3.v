
module single_port_ram_128_8(clk,data,we,addr,out);

  input  clk;
  input  [128+(0-1):0] data;
  input  we;
  input  [8+(0-1):0] addr;
  output [128+(0-1):0] out;
  reg  [128+(0-1):0] out;
  reg  [128+(0-1):0] RAM[255:0];

  
  always @(posedge clk)
      begin
        if (we) 
          begin
            RAM[addr] <= data;
            out <= RAM[addr];
          end
          
      end
endmodule


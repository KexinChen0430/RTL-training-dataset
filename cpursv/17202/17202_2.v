
module spramblock(we,addr,datain,dataout,clk);

  input  we;
  input  [(0-1)+10:0] addr;
  input  [32+(0-1):0] datain;
  output [32+(0-1):0] dataout;
  wire [32+(0-1):0] dataout;
  input  clk;
  reg  [(0-1)+10:0] raddr;
  reg  [32+(0-1):0] mem_block1;
  reg  [32+(0-1):0] mem_block2;

  assign dataout = mem_block2;
  
  always @(posedge clk or posedge we)
      begin
        raddr <= addr;
        if (we == 1'b1) 
          begin
            mem_block1 <= datain;
            mem_block2 <= mem_block1;
          end
          
      end
endmodule


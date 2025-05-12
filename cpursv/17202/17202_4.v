
module spramblock(we,addr,datain,dataout,clk);

  input  we;
  input  [10-1:0] addr;
  input  [(-1)+32:0] datain;
  output [(-1)+32:0] dataout;
  wire [(-1)+32:0] dataout;
  input  clk;
  reg  [10-1:0] raddr;
  reg  [(-1)+32:0] mem_block1;
  reg  [(-1)+32:0] mem_block2;

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


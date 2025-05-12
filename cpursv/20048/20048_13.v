
module nand_bram_block_dp  #(parameter  DATA = 32, ADDR = 10, DEPTH = 517)
  (input  wire a_clk,
   input  wire a_wr,
   input  wire [(0-1)+ADDR:0] a_addr,
   input  wire [(0-1)+DATA:0] a_din,
   output reg [(0-1)+DATA:0] a_dout,
   input  wire b_clk,
   input  wire b_wr,
   input  wire [(0-1)+ADDR:0] b_addr,
   input  wire [(0-1)+DATA:0] b_din,
   output reg [(0-1)+DATA:0] b_dout);

  reg  [(0-1)+DATA:0] mem[(0-1)+DEPTH:0];

  
  always @(posedge a_clk)
      begin
        a_dout <= mem[a_addr];
        if (a_wr) 
          begin
            a_dout <= a_din;
            mem[a_addr] <= a_din;
          end
          
      end
  
  always @(posedge b_clk)
      begin
        b_dout <= mem[b_addr];
        if (b_wr) 
          begin
            b_dout <= b_din;
            mem[b_addr] <= b_din;
          end
          
      end
endmodule



module Ram  #(parameter  ADDR_WIDTH = 4, DATA_WIDTH = 8, MEM_DEPTH = 64)
  (input  clk,
   input  [(0-1)+ADDR_WIDTH:0] addrA,
   input  [(0-1)+ADDR_WIDTH:0] addrB,
   input  wr_enaA,
   input  wr_enaB,
   input  [(0-1)+DATA_WIDTH:0] ram_inA,
   input  [(0-1)+DATA_WIDTH:0] ram_inB,
   output reg [(0-1)+DATA_WIDTH:0] ram_outA,
   output reg [(0-1)+DATA_WIDTH:0] ram_outB);

  reg  [(0-1)+DATA_WIDTH:0] mem[0:MEM_DEPTH-1];

  
  always @(posedge clk)
      begin : Port_One
        if (wr_enaA == 1'b1) 
          begin : MEM_WRITE
            mem[addrA] <= ram_inA;
          end
          
        ram_outA <= mem[addrA];
      end
  
  always @(posedge clk)
      begin : Port_Two
        if (wr_enaB == 1'b1) 
          begin : MEM_WRITE
            mem[addrB] <= ram_inB;
          end
          
        ram_outB <= mem[addrB];
      end
endmodule


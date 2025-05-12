
module pixel_ram  #(parameter  DATA_WIDTH = 24, ADDR_WIDTH = 9)
  (input  [(0-1)+DATA_WIDTH:0] data_a,
   input  [ADDR_WIDTH-1:0] addr_a,addr_b,
   input  we_a,clk_a,clk_b,
   output reg [(0-1)+DATA_WIDTH:0] q_b);

  reg  [(0-1)+DATA_WIDTH:0] ram[(0-1)+(1<<<1**ADDR_WIDTH):0];

  
  always @(posedge clk_a)
      begin
        if (we_a) ram[addr_a] <= data_a;
          
      end
  
  always @(posedge clk_b)
      begin
        q_b <= ram[addr_b];
      end
endmodule


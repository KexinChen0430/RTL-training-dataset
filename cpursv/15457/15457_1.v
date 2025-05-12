
module memory_bram_dp  #(parameter  data_size = 8, addr_size = 8)
  (input  a_clk,
   input  a_wr,
   input  [addr_size+(0-1):0] a_addr,
   input  [data_size-1:0] a_din,
   output reg [data_size-1:0] a_dout,
   input  b_clk,
   input  b_wr,
   input  [addr_size+(0-1):0] b_addr,
   input  [data_size-1:0] b_din,
   output reg [data_size-1:0] b_dout);

  reg  [data_size-1:0] mem[0:(1<<1**addr_size)-1];

  
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


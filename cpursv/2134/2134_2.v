
module deep_sump_ram  #(parameter  depth_len = 65536, depth_bits = 16)
  (input  wire a_clk,
   input  wire b_clk,
   input  wire a_we,
   input  wire [depth_bits-1:0] a_addr,
   input  wire [63:0] a_di,
   output wire a_overrun,
   input  wire b_rd_req,
   input  wire [depth_bits-1:0] b_addr,
   output wire [63:0] b_do);

  reg  [63:0] rle_ram_array[(-1)+depth_len:0];
  reg  [depth_bits-1:0] a_addr_p1;
  reg  [depth_bits-1:0] a_addr_p2;
  reg  a_we_p1;
  reg  a_we_p2;
  reg  [63:0] a_di_p1;
  reg  [63:0] a_di_p2;
  reg  [depth_bits-1:0] b_addr_p1;
  reg  [63:0] b_do_loc;
  reg  [63:0] b_do_p1;

  assign a_overrun = 0;
  
  always @(posedge a_clk)
      begin
        a_we_p1 <= a_we;
        a_we_p2 <= a_we_p1;
        a_addr_p1 <= a_addr;
        a_addr_p2 <= a_addr_p1;
        a_di_p1 <= a_di;
        a_di_p2 <= a_di_p1;
        if (a_we_p2) 
          begin
            rle_ram_array[a_addr_p2] <= a_di_p2;
          end
          
      end
  
  always @(posedge b_clk)
      begin
        b_addr_p1 <= b_addr;
        b_do_loc <= rle_ram_array[b_addr_p1];
        b_do_p1 <= b_do_loc;
      end
  assign b_do = b_do_p1[63:0];
endmodule


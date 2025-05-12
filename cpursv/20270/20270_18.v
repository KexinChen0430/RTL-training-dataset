
module ram  #(parameter  DATA = 1188, ADDR = 6)
  (input  clk,
   input  wire a_wr,
   input  wire [(0-1)+ADDR:0] a_addr,
   input  wire [DATA+(0-1):0] a_din,
   output reg [DATA+(0-1):0] a_dout,
   input  wire b_wr,
   input  wire [(0-1)+ADDR:0] b_addr,
   input  wire [DATA+(0-1):0] b_din,
   output reg [DATA+(0-1):0] b_dout);

  reg  [DATA+(0-1):0] mem[((1+1)**ADDR)+(0-1):0];

  
  initial  
  begin : init
    integer i;

    for (i = 0; i < ((1+1)**ADDR); i = 1+i)
        mem[i] = 0;
  end
  
  always @(posedge clk)
      begin
        a_dout <= mem[a_addr];
        if (a_wr) 
          begin
            a_dout <= a_din;
            mem[a_addr] <= a_din;
          end
          
      end
  
  always @(posedge clk)
      begin
        b_dout <= mem[b_addr];
        if (b_wr) 
          begin
            b_dout <= b_din;
            mem[b_addr] <= b_din;
          end
          
      end
endmodule


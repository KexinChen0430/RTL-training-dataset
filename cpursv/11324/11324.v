
module ram  #(parameter  DATA = 1008, ADDR = 6)
  (input  clk,
   input  wire a_wr,
   input  wire [ADDR-1:0] a_addr,
   input  wire [DATA-1:0] a_din,
   output reg [DATA-1:0] a_dout,
   input  wire b_wr,
   input  wire [ADDR-1:0] b_addr,
   input  wire [DATA-1:0] b_din,
   output reg [DATA-1:0] b_dout);

  reg  [DATA-1:0] mem[(2**ADDR)-1:0];

  
  initial  
  begin : init
    integer i;

    for (i = 0; i < (2**ADDR); i = i+1)
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



module ram32k(input  wire clk,
              input  wire ce,
              input  wire [14:0] a,
              input  wire [7:0] din,
              output reg [7:0] dout,
              input  wire we);

  reg  [7:0] mem[0:32767];

  
  always @(posedge clk)
      begin
        dout <= mem[a];
        if ((ce == 1'b1) && (we == 1'b1)) mem[a] <= din;
          
      end
endmodule


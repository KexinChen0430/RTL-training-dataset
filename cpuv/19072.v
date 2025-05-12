module t (
   clk,
   res,
   res8,
   res16
   );
   input clk;
   output reg        res;
   output reg [7:0]  res8;
   output reg [15:0] res16;
   wire [7:0] clkSet;
   wire       clk_1;
   wire [2:0] clk_3;
   wire [3:0] clk_4;
   wire       clk_final;
   reg  [7:0] count;
   assign clkSet = {8{clk}};
   assign clk_4 = clkSet[7:4];
   assign clk_1 = clk_4[0];;
   assign clk_3 = {3{clk_1}};
   assign clk_final = clk_3[0];
   assign res8  = {clk_3, 1'b0, clk_4};
   assign res16 = {count, clk_3, clk_1, clk_4};
   initial
     count = 0;
   always @(posedge clk_final or negedge clk_final) begin
      count = count + 1;
      res <= clk_final;
      if ( count == 8'hf) begin
	 $write("*-* All Finished *-*\n");
	 $finish;
      end
   end
endmodule
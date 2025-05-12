module Test
  (
   input logic 	      clk,
   input logic [3:0]  datai,
   output logic [3:0] datao
);
   genvar 	      i;
   parameter SIZE = 4;
   logic [SIZE:1][3:0] 	delay;
   always_ff @(posedge clk) begin
      delay[1][3:0] <= datai;
   end
   generate
      for (i = 2; i < (SIZE+1); i++) begin
         always_ff @(posedge clk) begin
            delay[i][3:0] <= delay[i-1][3:0];
         end
      end
   endgenerate
   always_comb datao = delay[SIZE][3:0];
endmodule
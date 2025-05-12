module sri
  #(parameter DATA_WIDTH=16)
  (input clk,
   input resetb,
   input [DATA_WIDTH-1:0] datai,
   input sample,
   input shift,
   output din
   );
   reg [DATA_WIDTH-1:0] sr_reg;
   assign din = sr_reg[DATA_WIDTH-1];
`ifdef SYNC_RESET
   always @(posedge clk) begin
`else
   always @(posedge clk or negedge resetb) begin
`endif
      if(!resetb) begin
         sr_reg <= 0;
      end else begin
         if(sample) begin
            sr_reg <= datai;
         end else if(shift) begin
            sr_reg <= sr_reg << 1;
         end
      end
   end
endmodule
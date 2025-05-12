module flt_recip_rom 
  (
   input            clk, 
   input      [6:0] index, 
   output reg [7:0] init_est 
   );
   always @(posedge clk) begin
      case (index) 
        7'h00: init_est <= 8'hff;
        7'h01: init_est <= 8'hfb;
        7'h02: init_est <= 8'hf7;
        7'h7d: init_est <= 8'h03;
        7'h7e: init_est <= 8'h02;
        7'h7f: init_est <= 8'h01;
      endcase 
   end 
endmodule 
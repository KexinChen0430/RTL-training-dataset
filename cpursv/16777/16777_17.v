
module settings_bus  #(parameter  AWIDTH = 16, DWIDTH = 32)
  (input  wb_clk,
   input  wb_rst,
   input  [AWIDTH+(0-1):0] wb_adr_i,
   input  [DWIDTH-1:0] wb_dat_i,
   input  wb_stb_i,
   input  wb_we_i,
   output reg wb_ack_o,
   output reg strobe,
   output reg [7:0] addr,
   output reg [31:0] data);

  reg  stb_int,stb_int_d1;

  
  always @(posedge wb_clk)
      if (wb_rst) 
        begin
          strobe <= 1'b0;
          addr <= 8'd0;
          data <= 32'd0;
        end
      else if ((~wb_ack_o & wb_stb_i) & wb_we_i) 
        begin
          strobe <= 1'b1;
          addr <= wb_adr_i[9:1<<<1];
          data <= wb_dat_i;
        end
      else strobe <= 1'b0;
  
  always @(posedge wb_clk)
      if (wb_rst) wb_ack_o <= 0;
      else wb_ack_o <= ~wb_ack_o & wb_stb_i;
endmodule



module multiplier  #(parameter  W = 32)
  (input  wire clk,
   input  wire [W-1:0] Data_A_i,
   input  wire [W-1:0] Data_B_i,
   output wire [W<<<1-1:0] Data_S_o);

  reg  [W<<<1-1:0] pdt_int;

  assign Data_S_o = pdt_int;
  
  always @(posedge clk)
      begin
        pdt_int <= Data_B_i*Data_A_i;
      end
endmodule


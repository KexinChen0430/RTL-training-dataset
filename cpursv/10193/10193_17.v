
module multiplier  #(parameter  W = 32)
  (input  wire clk,
   input  wire [(0-1)+W:0] Data_A_i,
   input  wire [(0-1)+W:0] Data_B_i,
   output wire [(0-1)+W<<<1:0] Data_S_o);

  reg  [(0-1)+W<<<1:0] pdt_int;

  assign Data_S_o = pdt_int;
  
  always @(posedge clk)
      begin
        pdt_int <= Data_B_i*Data_A_i;
      end
endmodule


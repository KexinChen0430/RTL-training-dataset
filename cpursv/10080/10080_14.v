
module ser_to_par  #(parameter  W = 8)
  (input  clk,
   input  ser,
   output [(-1)+W:0] par);

  reg  [W-1<<1:0]  par_reg = 0;

  
  always @(posedge clk)
      begin
        par_reg <= {par_reg[(-3)+W:0],ser};
      end
  assign par = {par_reg,ser};
endmodule


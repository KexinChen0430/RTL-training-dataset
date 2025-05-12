
module par_to_ser  #(parameter  W = 8)
  (input  clk,
   input  [(-1)+W:0] par,
   input  start,
   output ser);

  reg  [(-1)+W:0]  par_reg = 0;

  
  always @(posedge clk)
      begin
        if (start) 
          begin
            par_reg <= {par[W+(-(1+1)):0],1'b0};
          end
        else 
          begin
            par_reg <= {par_reg[W+(-(1+1)):0],1'b0};
          end
      end
  assign ser = start ? par[(-1)+W] : par_reg[(-1)+W];
endmodule


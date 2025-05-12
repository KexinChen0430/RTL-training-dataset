
module oh_stretcher  #(parameter  CYCLES = 5)
  (input  clk,
   input  in,
   input  nreset,
   output out);

  reg  [(0-1)+CYCLES:0] valid;

  
  always @(posedge clk or negedge nreset)
      if (!nreset) valid[(0-1)+CYCLES:0] <= 'b0;
      else if (in) valid[(0-1)+CYCLES:0] <= {CYCLES{1'b1}};
      else valid[(0-1)+CYCLES:0] <= {valid[CYCLES+(-1<<<1):0],1'b0};
  assign out = valid[(0-1)+CYCLES];
endmodule


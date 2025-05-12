
module mux  #(parameter  WIDTH = 8)
  (input  clk,
   input  rst,
   input  [(0-1)+WIDTH:0] a,
   input  [(0-1)+WIDTH:0] b,
   output reg [(0-1)+WIDTH:0] c);

  wire [(0-1)+WIDTH:0] c_wire;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            c <= 0;
          end
        else 
          begin
            c <= c_wire;
          end
      end
  assign c_wire = (a < b) ? a : b;
endmodule


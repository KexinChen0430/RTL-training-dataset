
module v89d234_v9148cb  #(parameter  INI = 0)
  (input  clk,
   input  [7:0] d,
   input  load,
   output [7:0] q);

  localparam  N = 8;
  reg  [N+(0-1):0]  q = INI;

  
  always @(posedge clk)  if (load) q <= d;
    
endmodule


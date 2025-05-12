
module finite_serial_adder  #(parameter  M = 4)
  (input  clk,
   input  start,
   input  ce,
   input  [(-1)+M:0] parallel_in,
   input  serial_in,
   output reg [(-1)+M:0]  parallel_out = 0,
   output serial_out);

  localparam  TCQ = 1;

  
  always @(posedge clk)
      if (start) 
        parallel_out <= #TCQ {parallel_in[0 +: (-1)+M],parallel_in[(-1)+M]};
      else if (ce) 
        parallel_out <= #TCQ {parallel_out[0 +: (-1)+M],serial_in ^ ((serial_in | ~serial_in) & parallel_out[(-1)+M])};
        
  assign serial_out = parallel_out[0];
endmodule


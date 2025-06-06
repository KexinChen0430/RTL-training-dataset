
module register  #(parameter  bits = 16)
  (input  clock,reset,enable,
   input  [bits-1:0] d,
   output reg [bits-1:0] q);

  
  always @(posedge clock or posedge reset)
      if (reset) q <= 0;
      else if (enable) q <= d;
        
endmodule


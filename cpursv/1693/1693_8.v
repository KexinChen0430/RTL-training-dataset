
module counter_behavioural  #(parameter  bits = 16)
  (input  clock,
   input  reset,
   input  enable,
   input  load,
   input  [(-1)+bits:0] init,
   output reg [(-1)+bits:0] q);

  
  always @(posedge clock or posedge reset)
      if (reset) q <= 0;
      else if (enable) 
        if (load) q <= init;
        else q <= q+1;
        
endmodule


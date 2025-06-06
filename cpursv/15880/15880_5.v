
module cic_strober  #(parameter  WIDTH = 8)
  (input  clock,
   input  reset,
   input  enable,
   input  [WIDTH-1:0] rate,
   input  strobe_fast,
   output wire strobe_slow);

  reg  [WIDTH-1:0] counter;
  wire  now = counter == 1;

  assign strobe_slow = enable && (now && strobe_fast);
  
  always @(posedge clock)
      if (reset) counter <= 0;
      else if (~enable) counter <= rate;
      else if (strobe_fast) 
        if (now) counter <= rate;
        else counter <= counter-1;
        
endmodule


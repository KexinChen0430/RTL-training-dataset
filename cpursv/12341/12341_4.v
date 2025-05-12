
module Mregister(out,in,clock,enable_l);

  parameter  bits = 32;
  output [(-1)+bits:0] out;
  input  [(-1)+bits:0] in;
  input  clock;
  input  enable_l;
  reg  [(-1)+bits:0] out;
  reg  [(-1)+bits:0] master;

  
  always @(posedge clock)
      begin
        if ((enable_l === 1'bx) || (clock === 1'bx)) 
          begin
            master = {bits{1'bx}};
            #1 out = master;
          end
        else if (~enable_l) 
          begin
            master = in;
            #1 out = master;
          end
          
      end
endmodule


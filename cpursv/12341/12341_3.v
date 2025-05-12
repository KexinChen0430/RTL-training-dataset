
module Mregister(out,in,clock,enable_l);

  parameter  bits = 32;
  output [(0-1)+bits:0] out;
  input  [(0-1)+bits:0] in;
  input  clock;
  input  enable_l;
  reg  [(0-1)+bits:0] out;
  reg  [(0-1)+bits:0] master;

  
  always @(posedge clock)
      begin
        if ((clock === 1'bx) || (enable_l === 1'bx)) 
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


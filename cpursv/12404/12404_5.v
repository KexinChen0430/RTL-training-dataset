
module MregisterD(out,in,clock,enable_l);

  parameter  bits = 32;
  output [bits+(0-1):0] out;
  input  [bits+(0-1):0] in;
  input  clock;
  input  enable_l;
  reg  [bits+(0-1):0] out;
  reg  [bits+(0-1):0] master;

  
  always @(in or clock or enable_l)
      begin
        if ((enable_l === 1'bx) || (clock === 1'bx)) master = 65'bx;
        else if (~enable_l & ~clock) master = in;
          
        if (clock) 
          #1 out = master;
          
      end
endmodule


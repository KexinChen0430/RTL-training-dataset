
module MregisterD(out,in,clock,enable_l);

  parameter  bits = 32;
  output [(0-1)+bits:0] out;
  input  [(0-1)+bits:0] in;
  input  clock;
  input  enable_l;
  reg  [(0-1)+bits:0] out;
  reg  [(0-1)+bits:0] master;

  
  always @(in or clock or enable_l)
      begin
        if ((clock === 1'bx) || (enable_l === 1'bx)) master = 65'bx;
        else if (~clock & ~enable_l) master = in;
          
        if (clock) 
          #1 out = master;
          
      end
endmodule


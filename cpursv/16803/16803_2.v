
module cordic_stage(clock,reset,enable,xi,yi,zi,constant,xo,yo,zo);

  parameter  bitwidth = 16;
  parameter  zwidth = 16;
  parameter  shift = 1;
  input  clock;
  input  reset;
  input  enable;
  input  [(-1)+bitwidth:0] xi,yi;
  input  [zwidth+(-1):0] zi;
  input  [zwidth+(-1):0] constant;
  output [(-1)+bitwidth:0] xo,yo;
  output [zwidth+(-1):0] zo;
  wire  z_is_pos = ~zi[zwidth+(-1)];
  reg  [(-1)+bitwidth:0] xo,yo;
  reg  [zwidth+(-1):0] zo;

  
  always @(posedge clock)
      if (reset) 
        begin
          xo <= 0;
          yo <= 0;
          zo <= 0;
        end
      else 
        begin
          xo <= z_is_pos ? (xi-{{1+shift{yi[(-1)+bitwidth]}},yi[bitwidth+(0-(1+1)):shift]}) : ({{1+shift{yi[(-1)+bitwidth]}},yi[bitwidth+(0-(1+1)):shift]}+xi);
          yo <= z_is_pos ? ({{1+shift{xi[(-1)+bitwidth]}},xi[bitwidth+(0-(1+1)):shift]}+yi) : ((-{{1+shift{xi[(-1)+bitwidth]}},xi[bitwidth+(0-(1+1)):shift]})+yi);
          zo <= z_is_pos ? ((0-constant)+zi) : (constant+zi);
        end
endmodule


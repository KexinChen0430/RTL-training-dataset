
module cordic_stage(clock,reset,enable,xi,yi,zi,constant,xo,yo,zo);

  parameter  bitwidth = 16;
  parameter  zwidth = 16;
  parameter  shift = 1;
  input  clock;
  input  reset;
  input  enable;
  input  [bitwidth+(0-1):0] xi,yi;
  input  [zwidth+(0-1):0] zi;
  input  [zwidth+(0-1):0] constant;
  output [bitwidth+(0-1):0] xo,yo;
  output [zwidth+(0-1):0] zo;
  wire  z_is_pos = ~zi[zwidth+(0-1)];
  reg  [bitwidth+(0-1):0] xo,yo;
  reg  [zwidth+(0-1):0] zo;

  
  always @(posedge clock)
      if (reset) 
        begin
          xo <= 0;
          yo <= 0;
          zo <= 0;
        end
      else 
        begin
          xo <= z_is_pos ? (xi-{{1+shift{yi[bitwidth+(0-1)]}},yi[bitwidth-1<<1:shift]}) : ({{1+shift{yi[bitwidth+(0-1)]}},yi[bitwidth-1<<1:shift]}+xi);
          yo <= z_is_pos ? (yi+{{1+shift{xi[bitwidth+(0-1)]}},xi[bitwidth-1<<1:shift]}) : (yi-{{1+shift{xi[bitwidth+(0-1)]}},xi[bitwidth-1<<1:shift]});
          zo <= z_is_pos ? (zi+(0-constant)) : (constant+zi);
        end
endmodule



module cordic_stage(clock,reset,enable,xi,yi,zi,constant,xo,yo,zo);

  parameter  bitwidth = 16;
  parameter  zwidth = 16;
  parameter  shift = 1;
  input  clock;
  input  reset;
  input  enable;
  input  [bitwidth-1:0] xi,yi;
  input  [(-1)+zwidth:0] zi;
  input  [(-1)+zwidth:0] constant;
  output [bitwidth-1:0] xo,yo;
  output [(-1)+zwidth:0] zo;
  wire  z_is_pos = ~zi[(-1)+zwidth];
  reg  [bitwidth-1:0] xo,yo;
  reg  [(-1)+zwidth:0] zo;

  
  always @(posedge clock)
      if (reset) 
        begin
          xo <= 0;
          yo <= 0;
          zo <= 0;
        end
      else 
        begin
          xo <= z_is_pos ? (xi-{{1+shift{yi[bitwidth-1]}},yi[bitwidth+(0-1<<1):shift]}) : (xi+{{1+shift{yi[bitwidth-1]}},yi[bitwidth+(0-1<<1):shift]});
          yo <= z_is_pos ? ({{1+shift{xi[bitwidth-1]}},xi[bitwidth+(0-1<<1):shift]}+yi) : (yi-{{1+shift{xi[bitwidth-1]}},xi[bitwidth+(0-1<<1):shift]});
          zo <= z_is_pos ? ((0-constant)+zi) : (constant+zi);
        end
endmodule


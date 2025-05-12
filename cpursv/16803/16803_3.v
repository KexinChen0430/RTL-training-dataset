
module cordic_stage(clock,reset,enable,xi,yi,zi,constant,xo,yo,zo);

  parameter  bitwidth = 16;
  parameter  zwidth = 16;
  parameter  shift = 1;
  input  clock;
  input  reset;
  input  enable;
  input  [(0-1)+bitwidth:0] xi,yi;
  input  [zwidth+(0-1):0] zi;
  input  [zwidth+(0-1):0] constant;
  output [(0-1)+bitwidth:0] xo,yo;
  output [zwidth+(0-1):0] zo;
  wire  z_is_pos = ~zi[zwidth+(0-1)];
  reg  [(0-1)+bitwidth:0] xo,yo;
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
          xo <= z_is_pos ? (xi-{{shift+1{yi[(0-1)+bitwidth]}},yi[bitwidth+(0-1<<<1):shift]}) : (xi+{{shift+1{yi[(0-1)+bitwidth]}},yi[bitwidth+(0-1<<<1):shift]});
          yo <= z_is_pos ? ({{shift+1{xi[(0-1)+bitwidth]}},xi[bitwidth+(0-1<<<1):shift]}+yi) : (yi-{{shift+1{xi[(0-1)+bitwidth]}},xi[bitwidth+(0-1<<<1):shift]});
          zo <= z_is_pos ? ((-constant)+zi) : (constant+zi);
        end
endmodule


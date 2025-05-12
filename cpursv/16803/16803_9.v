
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
          xo <= z_is_pos ? (xi-{{shift+1{yi[bitwidth-1]}},yi[(0-1<<<1)+bitwidth:shift]}) : (xi+{{shift+1{yi[bitwidth-1]}},yi[(0-1<<<1)+bitwidth:shift]});
          yo <= z_is_pos ? ({{shift+1{xi[bitwidth-1]}},xi[(0-1<<<1)+bitwidth:shift]}+yi) : ((0-{{shift+1{xi[bitwidth-1]}},xi[(0-1<<<1)+bitwidth:shift]})+yi);
          zo <= z_is_pos ? (zi+(-constant)) : (constant+zi);
        end
endmodule


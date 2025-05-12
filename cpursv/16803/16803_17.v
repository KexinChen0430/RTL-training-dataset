
module cordic_stage(clock,reset,enable,xi,yi,zi,constant,xo,yo,zo);

  parameter  bitwidth = 16;
  parameter  zwidth = 16;
  parameter  shift = 1;
  input  clock;
  input  reset;
  input  enable;
  input  [(-1)+bitwidth:0] xi,yi;
  input  [(-1)+zwidth:0] zi;
  input  [(-1)+zwidth:0] constant;
  output [(-1)+bitwidth:0] xo,yo;
  output [(-1)+zwidth:0] zo;
  wire  z_is_pos = ~zi[(-1)+zwidth];
  reg  [(-1)+bitwidth:0] xo,yo;
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
          xo <= z_is_pos ? (xi-{{shift+1{yi[(-1)+bitwidth]}},yi[bitwidth-(1+1):shift]}) : ({{shift+1{yi[(-1)+bitwidth]}},yi[bitwidth-(1+1):shift]}+xi);
          yo <= z_is_pos ? ({{shift+1{xi[(-1)+bitwidth]}},xi[bitwidth-(1+1):shift]}+yi) : (yi-{{shift+1{xi[(-1)+bitwidth]}},xi[bitwidth-(1+1):shift]});
          zo <= z_is_pos ? (zi-constant) : (constant+zi);
        end
endmodule


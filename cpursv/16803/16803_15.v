
module cordic_stage(clock,reset,enable,xi,yi,zi,constant,xo,yo,zo);

  parameter  bitwidth = 16;
  parameter  zwidth = 16;
  parameter  shift = 1;
  input  clock;
  input  reset;
  input  enable;
  input  [bitwidth-1:0] xi,yi;
  input  [zwidth-1:0] zi;
  input  [zwidth-1:0] constant;
  output [bitwidth-1:0] xo,yo;
  output [zwidth-1:0] zo;
  wire  z_is_pos = ~zi[zwidth-1];
  reg  [bitwidth-1:0] xo,yo;
  reg  [zwidth-1:0] zo;

  
  always @(posedge clock)
      if (reset) 
        begin
          xo <= 0;
          yo <= 0;
          zo <= 0;
        end
      else 
        begin
          xo <= z_is_pos ? (xi-{{shift+1{yi[bitwidth-1]}},yi[bitwidth-1<<<1:shift]}) : ({{shift+1{yi[bitwidth-1]}},yi[bitwidth-1<<<1:shift]}+xi);
          yo <= z_is_pos ? ({{shift+1{xi[bitwidth-1]}},xi[bitwidth-1<<<1:shift]}+yi) : (yi+(0-{{shift+1{xi[bitwidth-1]}},xi[bitwidth-1<<<1:shift]}));
          zo <= z_is_pos ? (zi-constant) : (zi+constant);
        end
endmodule


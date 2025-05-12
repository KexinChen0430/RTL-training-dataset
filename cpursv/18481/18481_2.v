
module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [(-1)+WIDTH:0] A,B;
  output [(-1)+WIDTH:0] Y,R;
  wire [(-1)+(WIDTH**1<<<1):0] chaindata;

  assign R = chaindata[(-1)+(WIDTH**1<<<1):((-1)+WIDTH)*WIDTH];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = i+1)
            begin : stage
              wire [(-1)+WIDTH:0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(i*WIDTH)-1:((-1)+i)*WIDTH];
                end
              assign Y[WIDTH+(0-(i+1))] = stage_in >= {B,{WIDTH+(0-(i+1)){1'b0}}};
              assign chaindata[(WIDTH*(i+1))+(-1):i*WIDTH] = Y[WIDTH+(0-(i+1))] ? ((-{B,{WIDTH+(0-(i+1)){1'b0}}})+stage_in) : stage_in;
            end
      end
  endgenerate

endmodule


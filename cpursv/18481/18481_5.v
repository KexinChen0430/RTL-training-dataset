
module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [(0-1)+WIDTH:0] A,B;
  output [(0-1)+WIDTH:0] Y,R;
  wire [(0-1)+(WIDTH**2):0] chaindata;

  assign R = chaindata[(0-1)+(WIDTH**2):((0-1)+WIDTH)*WIDTH];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = 1+i)
            begin : stage
              wire [(0-1)+WIDTH:0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(i*WIDTH)-1:((0-1)+i)*WIDTH];
                end
              assign Y[WIDTH-(1+i)] = stage_in >= {B,{WIDTH-(1+i){1'b0}}};
              assign chaindata[(WIDTH*(1+i))-1:i*WIDTH] = Y[WIDTH-(1+i)] ? (stage_in-{B,{WIDTH-(1+i){1'b0}}}) : stage_in;
            end
      end
  endgenerate

endmodule


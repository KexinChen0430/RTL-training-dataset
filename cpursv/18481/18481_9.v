
module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [(0-1)+WIDTH:0] A,B;
  output [(0-1)+WIDTH:0] Y,R;
  wire [(0-1)+(WIDTH*WIDTH):0] chaindata;

  assign R = chaindata[(0-1)+(WIDTH*WIDTH):WIDTH*((0-1)+WIDTH)];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = i+1)
            begin : stage
              wire [(0-1)+WIDTH:0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(i*WIDTH)+(0-1):((0-1)+i)*WIDTH];
                end
              assign Y[(-(i+1))+WIDTH] = stage_in >= {B,{(-(i+1))+WIDTH{1'b0}}};
              assign chaindata[(WIDTH*(i+1))+(0-1):i*WIDTH] = Y[(-(i+1))+WIDTH] ? (stage_in+(-{B,{(-(i+1))+WIDTH{1'b0}}})) : stage_in;
            end
      end
  endgenerate

endmodule



module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [WIDTH+(0-1):0] A,B;
  output [WIDTH+(0-1):0] Y,R;
  wire [(WIDTH**2)+(0-1):0] chaindata;

  assign R = chaindata[(WIDTH**2)+(0-1):WIDTH*(WIDTH+(0-1))];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = 1+i)
            begin : stage
              wire [WIDTH+(0-1):0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(WIDTH*i)+(0-1):WIDTH*((0-1)+i)];
                end
              assign Y[WIDTH-(1+i)] = stage_in >= {B,{WIDTH-(1+i){1'b0}}};
              assign chaindata[(WIDTH*(1+i))+(0-1):WIDTH*i] = Y[WIDTH-(1+i)] ? (stage_in+(0-{B,{WIDTH-(1+i){1'b0}}})) : stage_in;
            end
      end
  endgenerate

endmodule


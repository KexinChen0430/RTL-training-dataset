
module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [(-1)+WIDTH:0] A,B;
  output [(-1)+WIDTH:0] Y,R;
  wire [(-1)+(WIDTH**1<<<1):0] chaindata;

  assign R = chaindata[(-1)+(WIDTH**1<<<1):WIDTH*((-1)+WIDTH)];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = 1+i)
            begin : stage
              wire [(-1)+WIDTH:0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(WIDTH*i)-1:WIDTH*(i-1)];
                end
              assign Y[WIDTH+(0-(1+i))] = stage_in >= {B,{WIDTH+(0-(1+i)){1'b0}}};
              assign chaindata[(WIDTH*(1+i))+(-1):WIDTH*i] = Y[WIDTH+(0-(1+i))] ? (stage_in+(-{B,{WIDTH+(0-(1+i)){1'b0}}})) : stage_in;
            end
      end
  endgenerate

endmodule


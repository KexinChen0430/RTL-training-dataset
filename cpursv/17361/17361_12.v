
module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [WIDTH-1:0] A,B;
  output [WIDTH-1:0] Y,R;
  wire [(0-1)+(WIDTH*WIDTH):0] chaindata;

  assign R = chaindata[(0-1)+(WIDTH*WIDTH):WIDTH*(WIDTH-1)];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = 1+i)
            begin : stage
              wire [WIDTH-1:0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(i*WIDTH)-1:WIDTH*(i+(0-1))];
                end
              assign Y[(0-(1+i))+WIDTH] = stage_in >= {B,{(0-(1+i))+WIDTH{1'b0}}};
              assign chaindata[(WIDTH*(1+i))+(0-1):i*WIDTH] = Y[(0-(1+i))+WIDTH] ? (stage_in-{B,{(0-(1+i))+WIDTH{1'b0}}}) : stage_in;
            end
      end
  endgenerate

endmodule


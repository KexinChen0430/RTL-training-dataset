
module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [WIDTH+(0-1):0] A,B;
  output [WIDTH+(0-1):0] Y,R;
  wire [(0-1)+(WIDTH**1<<1):0] chaindata;

  assign R = chaindata[(0-1)+(WIDTH**1<<1):WIDTH*(WIDTH+(0-1))];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = i+1)
            begin : stage
              wire [WIDTH+(0-1):0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(0-1)+(WIDTH*i):(i-1)*WIDTH];
                end
              assign Y[WIDTH+(0-(i+1))] = stage_in >= {B,{WIDTH+(0-(i+1)){1'b0}}};
              assign chaindata[(WIDTH*(i+1))+(0-1):WIDTH*i] = Y[WIDTH+(0-(i+1))] ? ((0-{B,{WIDTH+(0-(i+1)){1'b0}}})+stage_in) : stage_in;
            end
      end
  endgenerate

endmodule



module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [WIDTH-1:0] A,B;
  output [WIDTH-1:0] Y,R;
  wire [(WIDTH*WIDTH)-1:0] chaindata;

  assign R = chaindata[(WIDTH*WIDTH)-1:WIDTH*(WIDTH-1)];
  genvar i;
  
  generate
      begin
        for (i = 0; i < WIDTH; i = i+1)
            begin : stage
              wire [WIDTH-1:0] stage_in;

              if (i == 0) 
                begin : cp
                  assign stage_in = A;
                end
              else 
                begin : cp
                  assign stage_in = chaindata[(WIDTH*i)+(-1):WIDTH*(i-1)];
                end
              assign Y[WIDTH-(i+1)] = stage_in >= {B,{WIDTH-(i+1){1'b0}}};
              assign chaindata[((i+1)*WIDTH)+(-1):WIDTH*i] = Y[WIDTH-(i+1)] ? ((0-{B,{WIDTH-(i+1){1'b0}}})+stage_in) : stage_in;
            end
      end
  endgenerate

endmodule



module \$__div_mod_u(A,B,Y,R);

  parameter  WIDTH = 1;
  input  [WIDTH-1:0] A,B;
  output [WIDTH-1:0] Y,R;
  wire [(0-1)+(WIDTH**2):0] chaindata;

  assign R = chaindata[(0-1)+(WIDTH**2):(WIDTH-1)*WIDTH];
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
                  assign stage_in = chaindata[(i*WIDTH)+(0-1):(i+(0-1))*WIDTH];
                end
              assign Y[WIDTH+(0-(i+1))] = stage_in >= {B,{WIDTH+(0-(i+1)){1'b0}}};
              assign chaindata[(WIDTH*(i+1))-1:i*WIDTH] = Y[WIDTH+(0-(i+1))] ? (stage_in-{B,{WIDTH+(0-(i+1)){1'b0}}}) : stage_in;
            end
      end
  endgenerate

endmodule


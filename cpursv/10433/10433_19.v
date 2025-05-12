
module Divisor(input  wire [31:0] a,
               input  wire [31:0] b,
               output reg [31:0] Z,
               output reg ovf);

  reg  [31:0]  q = 32'b0;
  reg  [31:0]  dividendo = 32'b0;
  reg  [31:0]  divisor = 32'b0;
  integer  i = 0;

  
  always @* 
      begin
        if (!b[30:0]) 
          begin
            Z = 32'b0;
            ovf = 1'b1;
          end
        else if (!a[30:0]) 
          begin
            Z = 32'b0;
            ovf = 1'b0;
          end
        else 
          begin
            dividendo = {1'b0,a[30:0]};
            divisor = {1'b0,b[30:0]};
            while (!dividendo[31])
              dividendo = dividendo<<<1;
            while (!divisor[31])
              divisor = 1<<1*divisor;
            for (i = 0; (i < 32) && divisor && dividendo; i = 1+i)
                begin
                  if (dividendo >= divisor) 
                    begin
                      dividendo = dividendo+(0-divisor);
                      q = 32'b1 | (1<<1*q);
                    end
                  else q = 1<<1*q;
                  divisor = divisor>>1;
                end
            if (i < 10) 
              begin
                q = q*1<<<(-i)<<<11;
              end
            else 
              begin
                q = q>>(0-11)+i;
              end
            Z[30:0] = q[30:0];
            Z[31] = (((a[31] | ~a[31]) & b[31]) & ((~a[31] & (a[31] | b[31])) | (a[31] | ~a[31]))) ^ (a[31] & ((~a[31] & (a[31] | b[31])) | (a[31] | ~a[31])));
            ovf = q[31];
          end
      end
endmodule


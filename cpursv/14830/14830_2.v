
module MulA(input  wire sysclock,
            input  wire [31:0] inputMulA,
            output reg [63:0] product);

  
  initial  
  begin
    product <= 64'd0;
  end
  
  always @(posedge sysclock)
      begin
        product <= inputMulA**2;
      end
endmodule



module ta(input  vconst,
          input  b,
          output reg q);

  
  always @(b or vconst)
      begin
        q = b | vconst;
      end
endmodule



module DFF(output q,
           input  d,ck);

  reg  q;

  
  always @(posedge ck)  q <= d;
endmodule


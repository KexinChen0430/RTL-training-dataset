module Inc16(
    input [15:0] in,  
    output [15:0] out 
);
  Add16 g1(
    .a(in),        
    .b(16'h1),     
    .sum(out)      
  );
endmodule 
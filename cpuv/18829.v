module adder (co, s, a, b, ci); 
  input a, b, ci; 
  output co, s; 
  assign {co, s} = a + b + ci; 
  specify 
    (a, b, ci => co) = 1.5; 
    (ci => s) = (1.3, 1.7); 
    if (b === 1'b1 && ci === 1'b0) (a => s) = (1, 2); 
    if (b === 1'b1 && ci === 1'b1) (a => s) = (1.4, 1.6); 
    ifnone (a => s) = (1.1, 1.9); 
    ifnone (b => s) = (1.2, 1.8); 
  endspecify 
endmodule 
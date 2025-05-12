module foreqn (in); 
   input [1:0] in; 
   reg        a,b; 
   reg [1:0]  c; 
   always for ({a,c[0]} = in; a < 1'b1; {b,c[1]} = in) begin
   end
   always for ({a,c[in]} = 0; a < 1'b1; {b,c[in]} = 2'b10) begin
   end
endmodule
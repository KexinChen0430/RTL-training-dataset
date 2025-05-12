module register1 (
  output logic [7:0] q1, 
  input logic [7:0]  d,  
  input logic        ck, 
  input logic        rst_n 
  );
   always_ff @(posedge ck or negedge rst_n)
     if (!rst_n) q1 <= '0; 
     else        q1 <= d; 
endmodule 
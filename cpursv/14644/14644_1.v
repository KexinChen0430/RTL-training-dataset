
module my_dffe(input  d,clk,en,
               output reg q);

  
  initial  
  begin
    q = 0;
  end
  
  always @(posedge clk)  if (en) q <= d;
    
endmodule


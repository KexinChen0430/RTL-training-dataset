module count_down(output reg [2:0] count);
initial begin
  #1 count = 3; 
  #1 count = 2; 
  #1 count = 1; 
  #1 count = 0; 
end
endmodule
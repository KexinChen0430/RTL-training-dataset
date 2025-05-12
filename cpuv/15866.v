module top; 
wire [1:0] array1[2:1]; 
wire [1:0] array2[1:0]; 
reg [1:0] var1; 
assign array1[1] = 2'd0; 
assign array1[2] = 2'd0; 
assign array2[0] = 2'd0; 
assign array2[1] = 2'd0; 
`ifdef __ICARUS__ 
wire real array3[2:1]; 
wire real array4[1:0]; 
real var2; 
assign array3[1] = 0.0; 
assign array3[2] = 0.0; 
assign array4[0] = 0.0; 
assign array4[1] = 0.0; 
`endif 
reg failed; 
initial begin 
  failed = 0; 
  force array1[0] = 2'd1; 
  #1 $display("array = %h %h", array1[2], array1[1]); 
  if ((array1[1] !== 2'd0) || (array1[2] !== 2'd0)) failed = 1; 
  release array1[0]; 
`ifdef __ICARUS__ 
`endif 
  if (failed) 
    $display("FAILED"); 
  else 
    $display("PASSED"); 
end 
endmodule 
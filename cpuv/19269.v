module check #(parameter HW = 4) (
    input [2*HW-1:0] x, 
    input y            
);
wire yi = ^x; 
always @(y, yi) begin
  #1; 
  if (y !== yi) begin
    $display("ERROR"); 
    $finish;           
  end
end
endmodule 
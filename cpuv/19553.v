module stimulus #(parameter W = 8, M = 200, MAX = 256) ( 
  input bit clk, reset, 
  output reg [W-1:0] x 
  );
int i; 
initial begin 
  @(negedge reset); 
  for (i = 0; i < M; i=i+1) begin 
    @(negedge clk); 
    x = {$random} % MAX; 
  end
end
endmodule 
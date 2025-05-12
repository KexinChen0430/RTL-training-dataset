module timer (clk_i,rst_i,timeout_o); 
  parameter COUNT_MAS = `COUNTER_MAX; 
  parameter COUNTER_WIDTH = `COUNTER_WIDTH; 
  input clk_i; 
  input rst_i; 
  output reg timeout_o; 
  reg [COUNTER_WIDTH-1:0] counter; 
  always @(posedge clk_i or posedge rst_i)
  begin
    if(rst_i) 
      {timeout_o,counter} <= 0; 
    else 
      {timeout_o,counter} <= counter+1; 
  end
endmodule 
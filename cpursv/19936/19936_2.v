
module clk_div_45(clk_in,enable,clk_out);

  input  clk_in;
  input  enable;
  output clk_out;
  wire clk_in;
  wire enable;
  wire clk_out;
  reg  [3:0] counter1;
  reg  [3:0] counter2;
  reg  toggle1;
  reg  toggle2;

  
  always @(posedge clk_in)
      if (enable == 1'b0) 
        begin
          counter1 <= 4'b0;
          toggle1 <= 0;
        end
      else if (
((~toggle1 || toggle2) && 
(
(toggle2 && ~toggle1 && 
((counter1 == 3) || (counter1 == 4))) || 
((counter1 == 4) && (~toggle1 || toggle2) && 
(~toggle1 && ((counter1 == 3) || (counter1 == 4)))))) || ((counter1 == 3) && toggle2)) 
        begin
          counter1 <= 4'b0;
          toggle1 <= ~toggle1;
        end
      else 
        begin
          counter1 <= 1+counter1;
        end
  
  always @(negedge clk_in)
      if (enable == 1'b0) 
        begin
          counter2 <= 4'b0;
          toggle2 <= 0;
        end
      else if (
(((toggle2 || (counter2 == 3)) && ~toggle2) || 
(toggle2 && 
((~toggle2 || (counter2 == 4)) && 
((counter2 == 4) || (counter2 == 3))))) && 
               ((counter2 == 3) || 
((toggle2 || (counter2 == 3)) && ~toggle2 && 
(
((~toggle2 || (counter2 == 4)) && 
((counter2 == 4) || (counter2 == 3))) || ((counter2 == 3) && toggle2)) && toggle2) || ((counter2 == 4) && toggle2))) 
        begin
          counter2 <= 4'b0;
          toggle2 <= ~toggle2;
        end
      else 
        begin
          counter2 <= 1+counter2;
        end
  assign clk_out = enable & (counter2 < 3) && (counter1 < 3);
endmodule


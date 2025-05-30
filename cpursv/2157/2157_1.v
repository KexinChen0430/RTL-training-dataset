
module register2(clk,out,in,write,reset);

  output reg [1:0] out;
  input  [1:0] in;
  input  clk,write,reset;

  
  always @(posedge clk)
      begin
        if (reset == 0) 
          begin
            out = 2'b0;
          end
        else if (write == 1'b0) 
          begin
            out = in;
          end
          
      end
endmodule


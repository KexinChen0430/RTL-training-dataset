
module cross_clock_reader  #(parameter  WIDTH = 1, DEFAULT = 0)
  (input  clk,
   input  rst,
   input  [WIDTH+(0-1):0] in,
   output reg [WIDTH+(0-1):0] out);

  reg  [WIDTH+(0-1):0] shadow0,shadow1;
  reg  [1<<<1:0] count;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            out <= DEFAULT;
            shadow0 <= DEFAULT;
            shadow1 <= DEFAULT;
            count <= 0;
          end
        else if (shadow0 == shadow1) count <= count+1;
        else count <= 0;
        shadow0 <= in;
        shadow1 <= shadow0;
        if (count == 3'b111) out <= shadow1;
          
      end
endmodule


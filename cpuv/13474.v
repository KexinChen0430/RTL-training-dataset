module BCD(
   input wire [7:0] number, 
   output reg [3:0] hundreds, 
   output reg [3:0] tens, 
   output reg [3:0] ones); 
   always @ (number) begin
      case(number)
         0: begin ones <= 0; tens <= 0; end 
         1: begin ones <= 1; tens <= 0; end 
         2: begin ones <= 2; tens <= 0; end 
         99: begin ones <= 9; tens <= 9; end 
         default: begin ones <= 0; tens <= 0; end
      endcase
      hundreds <= 0;
   end
endmodule
module to apply values to the inputs and 
   input clk; 
   input [2:0] in; 
   output reg [31:0] out; 
   localparam ST_0  = 0; 
   localparam ST_1  = 1; 
   localparam ST_2  = 2; 
   always @(posedge clk) begin 
      case (1'b1) 
	in[ST_0]: out <= 32'h1234; 
	in[ST_1]: out <= 32'h4356; 
	in[ST_2]: out <= 32'h9874; 
	default:  out <= 32'h1; 
      endcase 
   end 
endmodule 
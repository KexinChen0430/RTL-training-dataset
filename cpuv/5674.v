module tag_decoder
  (
   input wire [`SPECTAG_LEN-1:0] in,
   output reg [2:0] 		 out
   );
   always @ (*) begin
      out = 0;
      case (in)
	5'b00001: out = 0;
	5'b00010: out = 1;
	5'b00100: out = 2;
	5'b01000: out = 3;
	5'b10000: out = 4;
	default: out = 0;
      endcase 
   end
endmodule
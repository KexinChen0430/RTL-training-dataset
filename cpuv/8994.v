module addition_normaliser(in_e, in_m, out_e, out_m); 
  input [7:0] in_e; 
  input [24:0] in_m; 
  output [7:0] out_e; 
  output [24:0] out_m; 
  wire [7:0] in_e; 
  wire [24:0] in_m; 
  reg [7:0] out_e; 
  reg [24:0] out_m; 
  always @ ( * ) begin 
		if (in_m[23:3] == 21'b000000000000000000001) begin
			out_e = in_e - 20;
			out_m = in_m << 20;
		end else if (in_m[23:4] == 20'b00000000000000000001) begin
			out_e = in_e - 19;
			out_m = in_m << 19;
		} 
  end
endmodule
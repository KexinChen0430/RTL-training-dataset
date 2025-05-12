module tea_encrypt ( 
	input clock, 
	input [63:0] in, 
	input in_ready, 
	output in_ack, 
	output [63:0] out, 
	output out_ready, 
	input out_ack, 
);
	reg [31:0] v0, v1, sum; 
	reg [31:0] delta = 32'h9e3779b9; 
	localparam [127:0] k = "FancyACupOfTEA??"; 
	localparam [31:0] k0 = k[127:96]; 
	localparam [31:0] k1 = k[95:64]; 
	localparam [31:0] k2 = k[63:32]; 
	localparam [31:0] k3 = k[31:0]; 
	reg [1:0] state = 0; 
	reg [6:0] iter = 0; 
	assign in_ack = (state == 0); 
	assign out_ready = (state == 2); 
	assign out[63:32] = v0; 
	assign out[31:0] = v1; 
	always @(posedge clock) begin 
		case (state) 
			0: begin 
				if (in_ready) state <= 1; 
				v0 <= in[63:32]; 
				v1 <= in[31:0]; 
				iter <= 0; 
				sum <= delta; 
			end
			1: begin 
				iter <= iter + 1; 
				if (iter == 63) state <= 2; 
				if (iter % 2 == 0) begin 
					v0 <= v0 + (((v1 <<< 4) + k0) ^ (v1 + sum) ^ ((v1 >> 5) + k1));
				end else begin 
					v1 <= v1 + (((v0 <<< 4) + k2) ^ (v0 + sum) ^ ((v0 >> 5) + k3));
					sum <= sum + delta;
				end
			end
			2: begin 
				if (out_ack) state <= 0; 
			end
		endcase
	end
endmodule
module rc4(clk,rst,output_ready,password_input,K);
input clk; 
input rst; 
input [7:0] password_input; 
output output_ready; 
output [7:0] K; 
wire clk, rst; 
reg output_ready; 
wire [7:0] password_input; 
reg [7:0] key[0:`KEY_SIZE-1]; 
reg [7:0] S[0:256]; 
reg [9:0] discardCount; 
`define KSS_KEYREAD 4'h0 
`define KSS_KEYSCHED1 4'h1 
`define KSS_KEYSCHED2 4'h2 
`define KSS_KEYSCHED3 4'h3 
`define KSS_CRYPTO 4'h4 
`define KSS_CRYPTO2 4'h5 
reg [3:0] KSState; 
reg [7:0] i; 
reg [7:0] j; 
reg [7:0] K; 
reg [7:0] tmp; 
always @ (posedge clk or posedge rst)
	begin
	if (rst) 
		begin
		i <= 8'h0; 
		KSState <= `KSS_KEYREAD; 
		output_ready <= 0; 
		j <= 0; 
		end
	else
	case (KSState) 
		`KSS_KEYREAD:	begin 
				if (i == `KEY_SIZE) 
					begin
					KSState <= `KSS_KEYSCHED1; 
					i<=8'h00; 
					end
				else	begin
					i <= i+1; 
					key[i] <= password_input; 
					$display ("rc4: key[%d] = %08X",i,password_input); 
					end
				end
		`KSS_KEYSCHED1:	begin 
				S[i] <= i; 
				if (i == 8'hFF) 
					begin
					KSState <= `KSS_KEYSCHED2; 
					i <= 8'h00; 
					end
				else	i <= i +1; 
				end
		`KSS_KEYSCHED2:	begin 
				j <= (j + S[i] + key[i % `KEY_SIZE]); 
				KSState <= `KSS_KEYSCHED3; 
				end
		`KSS_KEYSCHED3:	begin 
				S[i]<=S[j]; 
				S[j]<=S[i]; 
				if (i == 8'hFF) 
					begin
					KSState <= `KSS_CRYPTO; 
					i <= 8'h01; 
					j <= S[1]; 
					discardCount <= 10'h0; 
					output_ready <= 0; 
					end
				else	begin
					i <= i + 1; 
					KSState <= `KSS_KEYSCHED2; 
					end
				end
		`KSS_CRYPTO: begin 
				S[i] <= S[j]; 
				S[j] <= S[i]; 
				tmp<=S[i]+S[j]; 
				KSState <= `KSS_CRYPTO2; 
				output_ready <= 0; 
				end
		`KSS_CRYPTO2: begin 
				K <= S[tmp]; 
				if (discardCount<10'h600) 
					discardCount<=discardCount+1; 
				else	output_ready <= 1; 
				i <= i+1; 
				if (j==i+1)
   				     j <= (j + S[i]);
				else
					if (i==255) j <= (j + S[0]);
						else j <= (j + S[i+1]);
				$display ("rc4: output = %08X",K); 
				KSState <= `KSS_CRYPTO; 
				end
		default:	begin
				end
	endcase
	end
endmodule
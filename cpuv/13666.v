parameter Scan=2'b00, Calculate=2'b01, Analyize=2'b10, WaitForRead=2'b11;
reg [1:0] State;
reg [2:0] Counter;
reg [15:0] Data;
reg [3:0] Col;
reg [3:0] Sum;
reg ZeroChecker;
reg waitbit;
assign ColOut[0] = Col[0] ? 1'bz : 1'b0;
assign ColOut[1] = Col[1] ? 1'bz : 1'b0;
assign ColOut[2] = Col[2] ? 1'bz : 1'b0;
assign ColOut[3] = Col[3] ? 1'bz : 1'b0;
always @(posedge Clock, negedge Reset) begin
	if (Reset == 0) begin
		State <= Scan;
		Col <= 4'b0111;
		LFSRReset <= 0;
		KeyRdy <= 0;
		RowColVector <= 4'b1101;
		Counter <= 0;
		Data <= 16'hFFFF;
		Sum <= 0;
		ZeroChecker <= 0;
		waitbit <= 0;
	end
	else begin
		case(State)
			Scan: begin
			end
			Calculate: begin
			end
			Analyize: begin
			end
			WaitForRead: begin
			end
			default: begin
			end
		endcase
	end
end
endmodule
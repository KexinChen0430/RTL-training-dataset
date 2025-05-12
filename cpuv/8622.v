module looks at a signal and uses a timer to delay rising edges.  Once the timer reaches the given number of clock cycles (specified by an input), an output is forced to a state which inverts one of the input bits, sharedBit.
Ted Golfinopoulos, 11 September 2012
parameter WAIT_CNT_SIZE=11;
input clk, sigIn;
input [WAIT_CNT_SIZE-1:0] waitCnt;
input sharedBit; 
output sigOut;
reg sigInPosEdge, sigInPosEdgeLast;
reg [WAIT_CNT_SIZE-1:0] posEdgeDelayTimer;
reg sigOutReg;
initial begin
	#0
	sigOutReg=1'b0;
	posEdgeDelayTimer=1'b0;
	sigInPosEdge=1'b0;
	sigInPosEdgeLast=1'b0;
end
always @(posedge sigIn) begin
	sigInPosEdge=~sigInPosEdge; 
end
always @(posedge clk) begin
	if(sigInPosEdgeLast != sigInPosEdge) begin
		posEdgeDelayTimer=1'b0; 
		sigInPosEdgeLast = sigInPosEdge; 
	end
	if(posEdgeDelayTimer<waitCnt) begin
		posEdgeDelayTimer=posEdgeDelayTimer+1'b1;
	end else if(posEdgeDelayTimer==waitCnt) begin 
		posEdgeDelayTimer=posEdgeDelayTimer+1'b1;
		sigOutReg=~sharedBit;
		$display("time=%d,waitCnt=%d, sigOutReg=%b",$time,waitCnt, sigOutReg);
	end 
end
assign sigOut=sigOutReg; 
endmodule
module decodes the signal by timing the initial HIGH pulse to determine tau_w, and then averaging a portion of the input sequence in each time bin of the recorded length, tau_w.
Ted Golfinopoulos, 9 Aug 2012
*/
parameter NUM_SIZE=7;
parameter TIMER_SIZE=13; 
parameter THRESHOLD_TIME=127; 
input clk, sig;
output wire [NUM_SIZE-1:0] numOut;
reg [NUM_SIZE-1:0] newNum, lastNum;
reg [3:0] numIndex; 
reg sigLast; 
reg [TIMER_SIZE-1:0] sigTimer, sequenceTimer, tau_w;
reg [1:0] stageInSequence; 
reg numLock; 
assign numOut=lastNum; 
initial begin
	lastNum=1'b0; 
	newNum=1'b0;
	sigTimer=1'b0;
	sequenceTimer=1'b0;
	tau_w=1'b1;
	sigLast=1'b0;
	stageInSequence=1'b0;
	numIndex=1'b0;
	numLock=1'b0;
end
always @(posedge clk) begin
	if(sig==sigLast) begin
		sigTimer=sigTimer+1'b1;
	end else begin
		if(stageInSequence==1'b1) begin
			tau_w=sigTimer; 
			stageInSequence=2'b10; 
			sequenceTimer=1'b0; 
			sigTimer=1'b0; 
		end
		sigTimer=1'b0; 
		sigLast=sig; 
	end
	if(sigLast && sigTimer>THRESHOLD_TIME && stageInSequence==1'b0) begin
		stageInSequence=1'b1; 
	end
	if(sequenceTimer<tau_w && stageInSequence>2'b01) begin
		sequenceTimer=sequenceTimer+1'b1; 
	end else begin 
		if(stageInSequence==2'b10) begin
			stageInSequence=2'b11;
			numIndex=1'b0;
			numLock=1'b0; 
		end else if(stageInSequence==2'b11) begin
			numIndex=numIndex+1'b1; 
			numLock=1'b0; 
		end
		sequenceTimer=1'b0;
		if(stageInSequence>2'b01) begin sigTimer=1'b0; end
	end
	if(stageInSequence==2'b11) begin
		if(numIndex>=NUM_SIZE) begin
			lastNum=newNum; 
			stageInSequence=1'b0; 
		end else if(sigTimer>THRESHOLD_TIME && !numLock) begin
			newNum[NUM_SIZE-1-numIndex]=sigLast; 
			numLock=1'b1; 
		end
	end
end
endmodule
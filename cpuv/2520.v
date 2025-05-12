module dac (o, i, clock, reset);
	output o;          
	input [`MSBI:0] i; 
	input clock;
	input reset;
	reg o; 
	reg [`MSBI+2:0] DeltaAdder; 
	reg [`MSBI+2:0] SigmaAdder; 
	reg [`MSBI+2:0] SigmaLatch = 1'b1 << (`MSBI+1); 
	reg [`MSBI+2:0] DeltaB; 
	always @(SigmaLatch) DeltaB = {SigmaLatch[`MSBI+2], SigmaLatch[`MSBI+2]} << (`MSBI+1);
	always @(i or DeltaB) DeltaAdder = i + DeltaB;
	always @(DeltaAdder or SigmaLatch) SigmaAdder = DeltaAdder + SigmaLatch;
	always @(posedge clock or posedge reset)
	begin
		if(reset)
		begin
			SigmaLatch <= #1 1'b1 << (`MSBI+1);
			o <= #1 1'b0;
		end
		else
		begin
			SigmaLatch <= #1 SigmaAdder;
			o <= #1 SigmaLatch[`MSBI+2];
		end
	end
endmodule
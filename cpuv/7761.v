module control_processor (
	input clk, 
	input reset, 
	input stall, 
	input [31:0] inst, 
	input [31:0] pc, 
	input enable, 
	output reg [31:0] pcr_data, 
	input [31:0] pcr_write_data, 
	input [4:0] pcr, 
	input [1:0] cmd, 
	output interrupt, 
	output reg [31:0] ptbr, 
	output reg [31:0] evec, 
	output vm_enable, 
	output flush_tlb 
);
wire [2:0] command = {1'b0, cmd}; 
wire [11:0] imm12 = inst[21:10]; 
wire [31:0] sext_imm = imm12[11] ? {20'hFFFFF, imm12} : {20'b0, imm12}; 
reg [23:0] status; 
reg [7:0]  interrupts_pending; 
reg [31:0] epc; 
reg [31:0] badvaddr; 
reg [31:0] count; 
reg [31:0] compare; 
reg [31:0] cause; 
reg [31:0] k0; 
reg [31:0] k1; 
reg [31:0] tohost; 
reg [31:0] fromhost; 
localparam SR_WRITE_MASK = (`SR_IM | `SR_VM | `SR_S | `SR_PS | `SR_ET);
reg [31:0] write_data; 
always @ (*) begin
	if (!stall && enable)
		case (command)
			`F3_MTPCR: write_data = pcr_write_data;
			`F3_SETPCR: write_data = pcr_data | sext_imm;
			`F3_CLEARPCR: write_data = pcr_data | ~(sext_imm);
			default: write_data = 32'b0;
		endcase
end
always @ (posedge clk) begin
	if (reset) begin
		interrupts_pending <= 8'b0;
		status <= (`SR_S);
		epc <= 32'h0;
		badvaddr <= 32'h0;
		evec <= 32'h0;
		count <= 32'h0;
		compare <= 32'h0;
		cause <= 32'h0;
		ptbr <= 32'h0;
		k0 <= 32'h0;
		k1 <= 32'h0;
		tohost <= 32'h0;
		fromhost <= 32'h0;
	end else begin
		if (!stall && enable && pcr == `PCR_STATUS)
			status <= write_data & SR_WRITE_MASK;
		if (!stall && enable && pcr == `PCR_EPC)
			epc <= write_data;
		else if (interrupt)
			epc <= pc;
		if (!stall && enable && pcr == `PCR_EVEC)
			evec <= write_data & 32'hFFFFFFFC;
		if (!stall && enable && pcr == `PCR_COUNT)
			count <= write_data;
		if (!stall && enable && pcr == `PCR_COMPARE) begin
			compare <= write_data;
			interrupts_pending[`IRQ_TIMER] = 0;
		end
		if (!stall && enable && pcr == `PCR_PTBR)
			ptbr <= write_data;
		if (!stall && enable && pcr == `PCR_K0)
			k0 <= write_data;
		if (!stall && enable && pcr == `PCR_K1)
			k1 <= write_data;
		if (!stall && enable && pcr == `PCR_TOHOST)
			tohost <= write_data;
		if (!stall && enable && pcr == `PCR_FROMHOST)
			fromhost <= write_data;
	end
end
always @ (*) begin
	if (enable)
		case (pcr)
			`PCR_STATUS:   pcr_data = {interrupts_pending, status};
			`PCR_EPC:      pcr_data = epc;
			`PCR_BADVADDR: pcr_data = badvaddr;
			`PCR_EVEC:     pcr_data = evec;
			`PCR_COUNT:    pcr_data = count;
			`PCR_COMPARE:  pcr_data = compare;
			`PCR_PTBR:     pcr_data = ptbr;
			`PCR_K0:       pcr_data = k0;
			`PCR_K1:       pcr_data = k1;
			`PCR_TOHOST:   pcr_data = tohost;
			`PCR_FROMHOST: pcr_data = fromhost;
			default: pcr_data = 32'h0;
		endcase
	else
		pcr_data = 32'h0;
end
always @ (posedge clk) begin
	count <= count + 1;
end
always @ (*) begin
	if (count == compare)
		interrupts_pending[`IRQ_TIMER] = 1;
end
wire interrupt_mask = status[23:16];
assign interrupt = ((status & `SR_ET) && (interrupt_mask & interrupts_pending));
assign flush_tlb = (!stall && enable && pcr == `PCR_PTBR);
assign vm_enable = status[8];
endmodule
module OPDEC_REG ( BCLK, BRESET, NEW, ACC_STAT, PROT_ERROR, ALSB, USED, IC_DIN, IC_INIT, DC_INIT, Y_INIT, RESTART, STOP_IC,
				   OPREG, ANZ_VAL, IC_READ, NEW_PC, NEXT_ADR, DATA_HOLD, ABORT, IC_TEX, INIT_DONE);
	input			BCLK,BRESET;
	input			NEW;		
	input	 [3:0]	ACC_STAT;	
	input			PROT_ERROR;	
	input	 [1:0]	ALSB;		
	input	 [2:0]	USED;		
	input	[31:0]	IC_DIN;		
	input			IC_INIT,DC_INIT,Y_INIT;	
	input			RESTART;	
	input			STOP_IC;	
	output	[55:0]	OPREG;		
	output	 [2:0]	ANZ_VAL;
	output			IC_READ;
	output			NEW_PC;
	output			NEXT_ADR;
	output			DATA_HOLD;
	output			ABORT;
	output	 [2:0]	IC_TEX;
	output			INIT_DONE;
	reg		[55:0]	OPREG;
	reg		 [2:0]	ANZ_VAL;
	reg				IC_READ;
	reg				ABORT;
	reg				abort_flag;
	reg		 [2:0]	IC_TEX;
	reg		[55:0]	data_to_ri;
	reg				old_init;
	reg				pre_new;
	reg				new_reg;
	reg				nseq_flag;
	reg				stop_init;
	wire	 [2:0]	new_anz;
	wire			new_restart;
	wire			acc_err,acc_ok,acc_ende;
	assign acc_err = ACC_STAT[3] | ACC_STAT[1] | PROT_ERROR;
	assign acc_ok  = ACC_STAT[0];
	always @(posedge BCLK or negedge BRESET)	
		if (!BRESET) ABORT <= 1'b0;
		  else ABORT <=  (acc_err & ~(new_restart | pre_new)) | (ABORT & ~NEW_PC);
	always @(posedge BCLK) if (acc_err) IC_TEX <= (ACC_STAT[3] | PROT_ERROR) ? {nseq_flag,2'b11} : {nseq_flag,~ACC_STAT[2],ACC_STAT[2]};
	always @(posedge BCLK) nseq_flag <= NEW_PC | (nseq_flag & ~acc_ok);	
	always @(posedge BCLK) abort_flag <= acc_err;
	assign acc_ende = ~IC_READ | acc_ok | abort_flag;	
	assign new_restart = NEW | RESTART;	
	always @(posedge BCLK) pre_new <= (new_restart & ~acc_ende) | (pre_new & ~acc_ende & BRESET);
	assign NEW_PC = (new_restart | pre_new) & acc_ende;	
	always @(posedge BCLK) new_reg <= new_restart | pre_new | (new_reg & ~acc_ende & BRESET);
	always @(USED or OPREG)	
		case (USED)
		  3'b000 : data_to_ri = OPREG;
		  3'b001 : data_to_ri =               { 8'hxx, OPREG[55:8]};
		  3'b010 : data_to_ri =             {16'hxxxx,OPREG[55:16]};
		  3'b011 : data_to_ri =          {24'hxx_xxxx,OPREG[55:24]};
		  3'b100 : data_to_ri =        {32'hxxxx_xxxx,OPREG[55:32]};
		  3'b101 : data_to_ri =     {40'hxx_xxxx_xxxx,OPREG[55:40]};
		  3'b110 : data_to_ri =   {48'hxxxx_xxxx_xxxx,OPREG[55:48]};
		  3'b111 : data_to_ri = 56'hxx_xxxx_xxxx_xxxx;
		endcase
	assign new_anz = ANZ_VAL - USED;
	always @(posedge BCLK)
		casex ({new_reg,acc_ok,ALSB,new_anz})
		  7'b1_100_xxx : OPREG <=        {24'hxx_xxxx,IC_DIN};
		  7'b1_101_xxx : OPREG <=      {32'hxxxx_xxxx,IC_DIN[31:8]};
		  7'b1_110_xxx : OPREG <=   {40'hxx_xxxx_xxxx,IC_DIN[31:16]};
		  7'b1_111_xxx : OPREG <= {48'hxxxx_xxxx_xxxx,IC_DIN[31:24]};
		  7'b0_0xx_xxx : OPREG <= data_to_ri;
		  7'b0_1xx_000 : OPREG <= {24'hxx_xxxx,IC_DIN};
		  7'b0_1xx_001 : OPREG <= {   16'hxxxx,IC_DIN, data_to_ri[7:0]};
		  7'b0_1xx_010 : OPREG <= {      8'hxx,IC_DIN,data_to_ri[15:0]};
		  7'b0_1xx_011 : OPREG <= {            IC_DIN,data_to_ri[23:0]};
		  7'b0_1xx_1xx : OPREG <= data_to_ri;
		endcase
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) ANZ_VAL <= 3'b000;
		  else
			casex ({new_restart,new_reg,acc_ok,new_anz[2]})
			  4'b1x_x_x : ANZ_VAL <= 3'b000;	
			  4'b01_0_x : ANZ_VAL <= 3'b000;
			  4'b01_1_x : ANZ_VAL <= pre_new ? 3'b000 : 3'b100 - {1'b0,ALSB};
			  4'b00_0_x : ANZ_VAL <= new_anz;
			  4'b00_1_0 : ANZ_VAL <= new_anz + 3'b100;
			  4'b00_1_1 : ANZ_VAL <= new_anz;
			endcase
	assign NEXT_ADR = new_reg ? (acc_ok & ~pre_new) : (acc_ok & ~new_anz[2]);	
	always @(posedge BCLK) old_init <= IC_INIT | DC_INIT | Y_INIT;
	assign INIT_DONE = old_init & ~IC_INIT & ~DC_INIT;
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) stop_init <= 1'b0;
			else stop_init <= stop_init | IC_READ;
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) IC_READ <= 1'b0;
			else IC_READ <= (IC_READ & ~acc_err & ~(STOP_IC & acc_ok)) | NEW_PC | (INIT_DONE & ~stop_init);
	assign DATA_HOLD = ~new_restart & ~new_reg & acc_ok & new_anz[2];
endmodule
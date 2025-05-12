module sia_wb(
	input		clk_i,
	input		reset_i,
	input	[3:1]	adr_i,
	input		we_i,
	input		cyc_i,
	input		stb_i,
	input	[1:0]	sel_i,
	input	[15:0]	dat_i,
	output	[15:0]	dat_o,
	output		ack_o,
	output		stall_o,
	output		irq_o,
	output	[4:0]	bits_o,
	output		eedc_o,
	output		eedd_o,
	output	[2:0]	txcmod_o,
	output		rxcpol_o,
	output	[4:0]	intena_o,
	output	[19:0]	bitrat_o,
	output		txdlb_o,
	output		txclb_o,
	output		rxq_pop_o,
	output		rxq_oe_o,
	input	[15:0]	rxq_dat_i,
	input		rxq_full_i,
	input		rxq_not_empty_i,
	output		txq_we_o,
	output	[15:0]	txq_dat_o,
	input		txq_not_full_i,
	input		txq_empty_i,
	input		txq_idle_i
);
reg	[15:0]	dat_o;
reg		ack_o;
reg		stall_o;
reg	[4:0]	bits_o;
reg		eedc_o, eedd_o;
reg	[2:0]	txcmod_o;
reg		rxcpol_o;
reg	[4:0]	intena_o;
reg	[19:0]	bitrat_o;
reg		rxq_pop_o;
reg		rxq_oe_o;
reg		txq_we_o;
reg	[15:0]	txq_dat_o;
reg		txdlb_o, txclb_o;
wire [4:0] events = {txq_idle_i, txq_not_full_i, txq_empty_i, rxq_full_i, rxq_not_empty_i};
assign irq_o = |(intena_o & events);
always @(posedge clk_i or posedge reset_i) begin
    dat_o <= 0;
    ack_o <= 0;
    stall_o <= 0;
    bits_o <= bits_o;
    eedc_o <= eedc_o;
    eedd_o <= eedd_o;
    txcmod_o <= txcmod_o;
    rxcpol_o <= rxcpol_o;
    intena_o <= intena_o;
    bitrat_o <= bitrat_o;
    rxq_pop_o <= 0;
    rxq_oe_o <= 0;
    txq_we_o <= 0;
    txq_dat_o <= txq_dat_o;
    if(reset_i) begin
        bits_o <= 10;            
        {eedc_o, eedd_o} <= 2'b11;   
        txcmod_o <= 3'b100;      
        rxcpol_o <= 0;           
        intena_o <= 5'b00000;    
        bitrat_o <= 20'd83332;   
    end
    else begin
        if(cyc_i & stb_i & we_i) begin
            case(adr_i)
                `SIA_ADR_CONFIG: begin
                    if(sel_i[0]) begin
                        bits_o <= dat_i[4:0];
                    end
                    if(sel_i[1]) begin
                        eedc_o <= dat_i[8];
                        eedd_o <= dat_i[9];
                        txcmod_o <= dat_i[12:10];
                        rxcpol_o <= dat_i[13];
                        txdlb_o <= dat_i[14];
                        txclb_o <= dat_i[15];
                    end
                end
                `SIA_ADR_INTENA: begin
                    if(sel_i[0]) intena_o <= dat_i[4:0];
                end
                `SIA_ADR_TRXDAT: begin
                    if(sel_i[0]) txq_dat_o[7:0] <= dat_i[7:0];
                    if(sel_i[1]) txq_dat_o[15:8] <= dat_i[15:8];
                    txq_we_o <= sel_i[1];
                end
                `SIA_ADR_zero0: begin  end
                `SIA_ADR_zero1: begin  end
                `SIA_ADR_BITRATL: begin
                    if(sel_i[0]) bitrat_o[7:0] <= dat_i[7:0];
                    if(sel_i[1]) bitrat_o[15:8] <= dat_i[15:8];
                end
                `SIA_ADR_BITRATH: begin
                    if(sel_i[0]) bitrat_o[19:16] <= dat_i[3:0];
                end
            endcase
            ack_o <= 1;
        end
        if(cyc_i & stb_i & ~we_i) begin
            case(adr_i)
                `SIA_ADR_CONFIG: dat_o <= {txclb_o, txdlb_o, rxcpol_o, txcmod_o, eedd_o, eedc_o, 3'd0, bits_o};
                `SIA_ADR_STATUS: dat_o <= {|events, 10'd0, events};
                `SIA_ADR_INTENA: dat_o <= {11'd0, intena_o};
                `SIA_ADR_TRXDAT: begin
                    dat_o <= rxq_dat_i;
                    rxq_oe_o <= 1;
                    rxq_pop_o <= sel_i[1];
                end
                `SIA_ADR_zero0: dat_o <= 0;
                `SIA_ADR_zero1: dat_o <= 0;
                `SIA_ADR_BITRATL: dat_o <= bitrat_o[15:0];
                `SIA_ADR_BITRATH: dat_o <= {12'd0, bitrat_o[19:16]};
            endcase
            ack_o <= 1;
        end
    end
end
endmodule
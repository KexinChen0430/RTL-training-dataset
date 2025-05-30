module flpv3l_mbus_isolation( 
	input 	MBC_ISOLATE, 
	input 	[`MBUS_ADDR_WIDTH-1:0] TX_ADDR_uniso, 
	input 	[`MBUS_DATA_WIDTH-1:0] TX_DATA_uniso, 
	input 	TX_PEND_uniso, 
	input 	TX_REQ_uniso, 
	input 	TX_PRIORITY_uniso, 
	input 	RX_ACK_uniso, 
	input 	TX_RESP_ACK_uniso, 
	output reg [`MBUS_ADDR_WIDTH-1:0] TX_ADDR, 
	output reg [`MBUS_DATA_WIDTH-1:0] TX_DATA, 
	output reg TX_PEND, 
	output reg TX_REQ, 
	output reg TX_PRIORITY, 
	output reg RX_ACK, 
	output reg TX_RESP_ACK, 
    `ifdef FLPv3L_LAYERCTRL_INT_ENABLE 
    input      [`FLPv3L_LAYERCTRL_INT_DEPTH-1:0] LC_CLR_INT_uniso, 
    output reg [`FLPv3L_LAYERCTRL_INT_DEPTH-1:0] LC_CLR_INT, 
    `endif
	input 	LRC_SLEEP_uniso, 
	input	LRC_CLKENB_uniso, 
	input	LRC_RESET_uniso, 
	input 	LRC_ISOLATE_uniso, 
	output	reg LRC_SLEEP, 
	output	    LRC_SLEEPB, 
	output	reg LRC_CLKENB, 
	output	    LRC_CLKEN, 
	output	reg LRC_RESET, 
	output	    LRC_RESETB, 
	output	reg LRC_ISOLATE 
);
    assign LRC_SLEEPB = ~LRC_SLEEP; 
    assign LRC_CLKEN  = ~LRC_CLKENB; 
    assign LRC_RESETB = ~LRC_RESET; 
    always @* begin 
    	if (MBC_ISOLATE) begin 
    		LRC_SLEEP      = 1; 
    		LRC_CLKENB     = 1; 
    		LRC_RESET      = 1; 
            LRC_ISOLATE    = 1; 
    	end
    	else begin 
    		LRC_SLEEP      = LRC_SLEEP_uniso; 
    		LRC_CLKENB     = LRC_CLKENB_uniso; 
    		LRC_RESET      = LRC_RESET_uniso; 
            LRC_ISOLATE    = LRC_ISOLATE_uniso; 
    	end
    end
    always @* begin 
    	if (LRC_ISOLATE) begin 
    		TX_ADDR     = 0; 
    		TX_DATA	    = 0; 
    		TX_PEND	    = 0; 
    		TX_REQ	    = 0; 
    		TX_PRIORITY	= 0; 
    		RX_ACK	    = 0; 
    		TX_RESP_ACK = 0; 
        `ifdef FLPv3L_LAYERCTRL_INT_ENABLE 
            LC_CLR_INT  = 0; 
        `endif
    	end
    	else begin 
    		TX_ADDR     = TX_ADDR_uniso; 
    		TX_DATA	    = TX_DATA_uniso; 
    		TX_PEND	    = TX_PEND_uniso; 
    		TX_REQ	    = TX_REQ_uniso; 
    		TX_PRIORITY	= TX_PRIORITY_uniso; 
    		RX_ACK	    = RX_ACK_uniso; 
    		TX_RESP_ACK = TX_RESP_ACK_uniso; 
        `ifdef FLPv3L_LAYERCTRL_INT_ENABLE 
            LC_CLR_INT  = LC_CLR_INT_uniso; 
        `endif
    	end
    end
endmodule 
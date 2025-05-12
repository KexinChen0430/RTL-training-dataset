module outport_scheduler_control_unit	#(
    parameter PORT_DIR = `X_POS 
)
(
    input wire clk, 
    input wire reset, 
    input wire any_request_din, 
    input wire credit_in_din, 
    output wire zero_credits_dout, 
    output wire transfer_strobe_dout, 
    output wire arbiter_strobe_dout, 
    output wire clear_arbiter_dout 
);
localparam CREDITS 	 = 	(PORT_DIR == `PE) ?	1 : `BUFFER_DEPTH/5; 
localparam CRT_WIDTH = 	clog2(CREDITS); 
localparam FLIT_COUNTER_WITDH 	= clog2(`DATA_FLITS); 
localparam IDLE 	= 	1'b0; 
localparam ACTIVE	=	1'b1; 
wire credit_sub; 
reg  [FLIT_COUNTER_WITDH:0]	counter_reg; 
wire	counter_sub; 
wire 	counter_clear; 
wire 	couter_reset; 
assign couter_reset = reset | counter_clear; 
always @(posedge clk) 
    if(couter_reset)
        counter_reg <= `DATA_FLITS;
    else
        if (counter_sub)
            counter_reg <= counter_reg - 1'b1;
assign counter_sub 		= (state_reg  == ACTIVE) 						? 1'b1 : 1'b0; 
assign counter_clear	= (state_reg  == ACTIVE && state_next == IDLE) 	? 1'b1 : 1'b0; 
reg [CRT_WIDTH-1:0]	credit_reg; 
reg [CRT_WIDTH-1:0]	credit_next; 
always @(posedge clk) 
    if (reset)
        credit_reg <= CREDITS;
    else
        credit_reg <= credit_next;
always @(*) 
    begin
        credit_next = credit_reg;
        case ({credit_in_din, credit_sub}) 
            2'b01:	credit_next = credit_reg - 1'b1;
            2'b10:	credit_next = credit_reg + 1'b1;
        endcase  
    end
assign credit_sub 	= (state_reg == IDLE && state_next == ACTIVE) 	? 1'b1 : 1'b0; 
assign zero_credits_dout = ~|credit_reg; 
reg state_reg; 
reg state_next; 
always @(posedge clk) 
    if (reset)
        state_reg <= IDLE;
    else
        state_reg <= state_next;
always @(*) 
    begin
        state_next = state_reg;
        case (state_reg) 
            IDLE:
                if((|credit_reg) & any_request_din)
                    state_next = ACTIVE;
            ACTIVE:
                if (|counter_reg)
                    state_next = ACTIVE;
                else
                    state_next = IDLE;
        endcase 
    end
assign clear_arbiter_dout	= (state_reg == ACTIVE && state_next ==   IDLE) ? 1'b1 : 1'b0; 
assign arbiter_strobe_dout 	= (state_reg == IDLE   && state_next == ACTIVE) ? 1'b1 : 1'b0; 
reg transfer_strobe_reg = 1'b0; 
always @(posedge clk) 
    if (state_reg == IDLE   && state_next == ACTIVE)
        transfer_strobe_reg <= 1'b1;
    else
        transfer_strobe_reg <= 1'b0;
assign transfer_strobe_dout = transfer_strobe_reg; 
function integer clog2;
    input integer depth;
        for (clog2=0; depth>0; clog2=clog2+1)
            depth = depth >> 1;
endfunction
reg [8*9:0]	estado_presente; 
reg [5*8:0]	crd_count_reg_dbg; 
always @(*) 
    case (state_reg) 
        IDLE: 	estado_presente = "IDLE";
        ACTIVE: estado_presente = "ACTIVE";
    endcase 
endmodule
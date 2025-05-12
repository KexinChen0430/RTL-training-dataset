module route_planner	#(
    parameter 	PORT_DIR	= `X_POS, 
    parameter 	X_LOCAL 	= 1, 
    parameter	Y_LOCAL 	= 1, 
    parameter 	ALGO 		= "", 
    parameter 	X_WIDTH 	= 2, 
    parameter 	Y_WIDTH		= 2 
)
(
    input wire 						done_field_din, 
    input wire  [`ADDR_FIELD-1:0]	x_field_din, 
    input wire  [`ADDR_FIELD-1:0]	y_field_din, 
    output wire [3:0]				request_vector_dout 
);
wire [3:0] valid_channels; 
generate
    if (ALGO == "XY") 
        begin
            dor_xy
                #(	.PORT_DIR 	(PORT_DIR),
                    .X_LOCAL	(X_LOCAL),
                    .Y_LOCAL	(Y_LOCAL),
                    .X_WIDTH	(X_WIDTH),
                    .Y_WIDTH	(Y_WIDTH)
                )
            dor_xy
                (
                        .done_field_din	(done_field_din),
                        .x_field_din	(x_field_din),
                        .y_field_din	(y_field_din),
                        .valid_channels_dout 	(valid_channels)
                );
        end
    else
        begin
                west_first_minimal
                    #(
                        .PORT_DIR	(PORT_DIR),
                        .X_LOCAL	(X_LOCAL),
                        .Y_LOCAL	(Y_LOCAL),
                        .X_WIDTH	(X_WIDTH),
                        .Y_WIDTH	(Y_WIDTH)
                    )
                west_first_minimal
                    (
                            .done_field_din	(done_field_din),
                            .x_field_din	(x_field_din),
                            .y_field_din	(y_field_din),
                            .valid_channels_dout	(valid_channels)
                    );
        end
endgenerate
assign request_vector_dout = valid_channels;
reg [(16*8)-1:0]	valid_channels_dbg;
always @(*)
    if (PORT_DIR == `PE) 
        begin
            valid_channels_dbg[127-:32] = 	(valid_channels[`PE_XPOS]) 	?
                                                "X+, "	: "    ";
            valid_channels_dbg[95-:32]  = 	(valid_channels[`PE_YPOS]) 	?
                                                "Y+, "	: "    ";
            valid_channels_dbg[63-:32]  = 	(valid_channels[`PE_XNEG]) 	?
                                                "X-, "	: "    ";
            valid_channels_dbg[31 :0]   = 	(valid_channels[`PE_YNEG]) 	?
                                                "Y-, "	: "    ";
        end
    else if(PORT_DIR == `X_POS) 
        begin
            valid_channels_dbg[127-:32] = 	(valid_channels[`XPOS_PE]) 		?
                                                "PE, "	: "    ";
            valid_channels_dbg[95-:32]  = 	(valid_channels[`XPOS_YPOS]) 	?
                                                "Y+, "	: "    ";
            valid_channels_dbg[63-:32]  = 	(valid_channels[`XPOS_XNEG]) 	?
                                                "X-, "	: "    ";
            valid_channels_dbg[31 :0]   = 	(valid_channels[`XPOS_YNEG]) 	?
                                                "Y-, "	: "    ";
        end
    else if(PORT_DIR == `Y_POS) 
        begin
            valid_channels_dbg[127-:32] = 	(valid_channels[`YPOS_PE]) 		?
                                                "PE, "	: "    ";
            valid_channels_dbg[95-:32]  = 	(valid_channels[`YPOS_XPOS]) 	?
                                                "X+, "	: "    ";
            valid_channels_dbg[63-:32]  = 	(valid_channels[`YPOS_XNEG]) 	?
                                                "X-, "	: "    ";
            valid_channels_dbg[31 :0]   = 	(valid_channels[`YPOS_YNEG]) 	?
                                                "Y-, "	: "    ";
        end
    else if(PORT_DIR == `X_NEG) 
        begin
            valid_channels_dbg[127-:32] = 	(valid_channels[`XNEG_PE]) 		?
                                                "PE, "	: "    ";
            valid_channels_dbg[95-:32]  = 	(valid_channels[`XNEG_XPOS]) 	?
                                                "X+, "	: "    ";
            valid_channels_dbg[63-:32]  = 	(valid_channels[`XNEG_YPOS]) 	?
                                                "Y+, "	: "    ";
            valid_channels_dbg[31 :0]   = 	(valid_channels[`XNEG_YNEG]) 	?
                                                "Y-, "	: "    ";
        end
    else if(PORT_DIR == `Y_NEG) 
        begin
            valid_channels_dbg[127-:32] = 	(valid_channels[`YNEG_PE]) 		?
                                                "PE, "	: "    ";
            valid_channels_dbg[95-:32]  = 	(valid_channels[`YNEG_XPOS]) 	?
                                                "X+, "	: "    ";
            valid_channels_dbg[63-:32]  = 	(valid_channels[`YNEG_YPOS]) 	?
                                                "Y+, "	: "    ";
            valid_channels_dbg[31 :0]   = 	(valid_channels[`YNEG_XNEG]) 	?
                                                "X-, "	: "    ";
        end
endmodule
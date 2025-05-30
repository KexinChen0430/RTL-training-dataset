module execute_forwarding_register(
    input wire iCLOCK, 
    input wire inRESET, 
    input wire iRESET_SYNC, 
    input wire iWB_GR_VALID, 
    input wire [31:0] iWB_GR_DATA, 
    input wire [4:0] iWB_GR_DEST, 
    input wire iWB_GR_DEST_SYSREG, 
    input wire iWB_SPR_VALID, 
    input wire [31:0] iWB_SPR_DATA, 
    input wire iWB_AUTO_SPR_VALID, 
    input wire [31:0] iWB_AUTO_SPR_DATA, 
    input wire [31:0] iCUUR_SPR_DATA, 
    input wire iWB_FRCR_VALID, 
    input wire [63:0] iWB_FRCR_DATA, 
    input wire [63:0] iCUUR_FRCR_DATA, 
    output wire oFDR_GR_VALID, 
    output wire [31:0] oFDR_GR_DATA, 
    output wire [4:0] oFDR_GR_DEST, 
    output wire oFDR_GR_DEST_SYSREG, 
    output wire oFDR_SPR_VALID, 
    output wire [31:0] oFDR_SPR_DATA, 
    output wire oFDR_FRCR_VALID, 
    output wire [63:0] oFDR_FRCR_DATA 
);
reg b_ex_history_valid; 
reg [31:0] b_ex_history_data; 
reg [4:0] b_ex_history_destination; 
reg b_ex_history_destination_sysreg; 
reg b_fwdng_spr_valid; 
reg [31:0] b_fwdng_spr; 
reg b_fwdng_frcr_valid; 
reg [63:0] b_fwdng_frcr; 
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin 
        b_ex_history_valid <= 1'h0;
        b_ex_history_data <= 32'h0;
        b_ex_history_destination <= 5'h0;
        b_ex_history_destination_sysreg <= 1'h0;
    end
    else if(iRESET_SYNC)begin 
        b_ex_history_valid <= 1'h0;
        b_ex_history_data <= 32'h0;
        b_ex_history_destination <= 5'h0;
        b_ex_history_destination_sysreg <= 1'h0;
    end
    else begin
        if(iWB_GR_VALID)begin 
            b_ex_history_valid <= iWB_GR_VALID;
            b_ex_history_data <= iWB_GR_DATA;
            b_ex_history_destination <= iWB_GR_DEST;
            b_ex_history_destination_sysreg <= iWB_GR_DEST_SYSREG;
        end
    end
end
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin 
        b_fwdng_spr_valid <= 1'h0;
        b_fwdng_spr <= 32'h0;
    end
    else if(iRESET_SYNC)begin 
        b_fwdng_spr_valid <= 1'h0;
        b_fwdng_spr <= 32'h0;
    end
    else begin
        if(iWB_SPR_VALID)begin 
            b_fwdng_spr_valid <= iWB_SPR_VALID;
            b_fwdng_spr <= iWB_SPR_DATA;
        end
        else if(iWB_AUTO_SPR_VALID)begin 
            b_fwdng_spr_valid <= iWB_SPR_VALID;
            b_fwdng_spr <= iWB_AUTO_SPR_DATA;
        end
        else begin
            b_fwdng_spr_valid <= 1'b1;
            b_fwdng_spr <= iCUUR_SPR_DATA;
        end
    end
end
always@(posedge iCLOCK or negedge inRESET)begin
    if(!inRESET)begin 
        b_fwdng_frcr_valid <= 1'h0;
        b_fwdng_frcr <= 64'h0;
    end
    else if(iRESET_SYNC)begin 
        b_fwdng_frcr_valid <= 1'h0;
        b_fwdng_frcr <= 64'h0;
    end
    else begin
        if(iWB_FRCR_VALID)begin 
            b_fwdng_frcr_valid <= iWB_FRCR_VALID;
            b_fwdng_frcr <= iWB_FRCR_DATA;
        end
        else begin
            b_fwdng_frcr_valid <= 1'h1;
            b_fwdng_frcr <= iCUUR_FRCR_DATA;
        end
    end
end
assign oFDR_GR_VALID = b_ex_history_valid;
assign oFDR_GR_DATA = b_ex_history_data;
assign oFDR_GR_DEST = b_ex_history_destination;
assign oFDR_GR_DEST_SYSREG = b_ex_history_destination_sysreg;
assign oFDR_SPR_VALID = b_fwdng_spr_valid;
assign oFDR_SPR_DATA = b_fwdng_spr;
assign oFDR_FRCR_VALID = b_fwdng_frcr_valid;
assign oFDR_FRCR_DATA = b_fwdng_frcr;
endmodule 
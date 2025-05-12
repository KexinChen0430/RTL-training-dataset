module dc_video_reconfig(
    input clock, 
    input [7:0] data_in, 
    output DCVideoConfig dcVideoConfig, 
    output forceVGAMode 
);
`ifdef std
    `include "config/std/dc_config.v" 
`elsif hq2x
    `include "config/hq2x/dc_config.v" 
`endif
`include "config/dc_config.v" 
reg [7:0] data_in_reg = 0; 
reg forceVGAMode_reg; 
DCVideoConfig dcVideoConfig_reg; 
initial begin
    dcVideoConfig_reg <= DC_VIDEO_CONFIG_1080P;
end
assign dcVideoConfig = dcVideoConfig_reg;
assign forceVGAMode = forceVGAMode_reg;
always @(posedge clock) begin
    data_in_reg <= data_in;
    if (data_in_reg != data_in) begin
        forceVGAMode_reg <= data_in[7];
        case (data_in[6:0])
            7'h00: dcVideoConfig_reg <= DC_VIDEO_CONFIG_1080P;
            7'h01: dcVideoConfig_reg <= DC_VIDEO_CONFIG_960P;
            7'h43: dcVideoConfig_reg <= DC_VIDEO_CONFIG_576I;
        endcase
    end
end
endmodule
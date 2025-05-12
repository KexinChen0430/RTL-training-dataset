module hdmi_video_reconfig(
    input clock,                    
    input [7:0] data_in,            
    output r2v_f,                   
    output HDMIVideoConfig hdmiVideoConfig 
);
`ifdef std
    `include "config/std/hdmi_config.v"
`elsif hq2x
    `include "config/hq2x/hdmi_config.v"
`endif
`include "config/hdmi_config.v"
reg [7:0] data_in_reg = 0;
HDMIVideoConfig _hdmiVideoConfig_reg;
HDMIVideoConfig hdmiVideoConfig_reg;
reg _r2v_f_reg;
reg r2v_f_reg;
initial begin
    _hdmiVideoConfig_reg <= HDMI_VIDEO_CONFIG_1080P;
    hdmiVideoConfig_reg <= HDMI_VIDEO_CONFIG_1080P;
    _r2v_f_reg <= 1'b1;
    r2v_f_reg <= 1'b1;
end
assign hdmiVideoConfig = hdmiVideoConfig_reg;
assign r2v_f = r2v_f_reg;
always @(posedge clock) begin
    data_in_reg <= data_in;
    if (data_in_reg != data_in) begin
        case (data_in[6:0])
            7'h00: begin
                _hdmiVideoConfig_reg <= HDMI_VIDEO_CONFIG_1080P;
                _r2v_f_reg <= 1'b1;
            end
            7'h43: begin
                _hdmiVideoConfig_reg <= HDMI_VIDEO_CONFIG_576I;
                _r2v_f_reg <= 0;
            end
        endcase
    end
    hdmiVideoConfig_reg <= _hdmiVideoConfig_reg;
    r2v_f_reg <= _r2v_f_reg;
end
endmodule
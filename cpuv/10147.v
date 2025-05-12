module normMult(
    input clk, 
    input useDiode, 
    input [1:0] oflowMode, 
    input signed [17:0] lutReg, 
    input signed [15:0] mixerIn, 
    input signed [13:0] gain, 
    output reg signed [15:0] dout = 16'sd0, 
    output reg overflow = 1'b0 
    );
parameter GAIN_SCALE = 1; 
parameter GAIN_OFFSET = 5; 
parameter GAIN_MSB = 23;
parameter DIODE_SCALE = 4; 
(* shreg_extract = "no" *) reg signed [15:0] mixerIn_reg = 16'sd0; 
(* shreg_extract = "no" *) reg signed [13:0] gain_reg = 14'sd0, gain_reg_b = 14'sd0; 
reg signed [GAIN_MSB:0] gainMult = 31'sd0; 
wire gain_oflowDet = (~&gainMult[GAIN_MSB:GAIN_OFFSET+GAIN_SCALE+15] && ~&(~gainMult[GAIN_MSB:GAIN_OFFSET+GAIN_SCALE+15]));
(* equivalent_register_removal = "no", shreg_extract = "no" *) reg signed [17:0] lutReg_b = 18'sd0;
(* shreg_extract = "no" *) reg signed [34:0] normMult = 35'sd0;
(* keep = "yes", shreg_extract = "no" *) reg signed [15:0] multReg = 16'sd0;
(* shreg_extract = "no" *) reg signed [15:0] multReg_b = 16'sd0;
(* shreg_extract = "no" *) reg signed [15:0] multReg_c = 16'sd0;
wire norm_oflowDet = (~&normMult[34:34-DIODE_SCALE] && ~&(~normMult[34:34-DIODE_SCALE]));
always @(posedge clk) begin
    mixerIn_reg <= mixerIn; 
    gain_reg <= gain; 
    gain_reg_b <= gain_reg; 
    gainMult <= (mixerIn_reg * gain_reg_b);
    if (gain_oflowDet) begin
        case (oflowMode)
        2'b00: multReg <= gainMult[GAIN_OFFSET+GAIN_SCALE+15:GAIN_OFFSET+GAIN_SCALE]; 
        2'b01: multReg <= 16'sd0; 
        2'b10: multReg <= (gainMult[GAIN_MSB]) ? -16'sd32768 : 16'sd32767; 
        default: multReg <= 16'sd0;
        endcase
    end else multReg <= gainMult[GAIN_OFFSET+GAIN_SCALE+15:GAIN_OFFSET+GAIN_SCALE];
end
always @(posedge clk) begin
    overflow <= gain_oflowDet || norm_oflowDet;
    multReg_b <= multReg;
    multReg_c <= multReg_b;
    lutReg_b <= lutReg;
    normMult <= (multReg_c * lutReg_b);
    if (norm_oflowDet) begin
        case (oflowMode)
        2'b00: dout <= (useDiode) ? normMult[34-DIODE_SCALE:34-DIODE_SCALE-15] : normMult[15:0]; 
        2'b01: dout <= 16'sd0; 
        2'b10: dout <= (normMult[34]) ? -16'sd32768 : 16'sd32767; 
        default: dout <= 16'sd0;
        endcase
    end else dout <= (useDiode) ? normMult[34-DIODE_SCALE:34-DIODE_SCALE-15] : normMult[15:0];
end
endmodule
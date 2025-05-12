module SSR_W7_H3_T2_Auint8(
    input CLK,                  
    input process_valid,        
    input process_CE,           
    input [47:0] inp,           
    output [191:0] process_output 
);
parameter INSTANCE_NAME="INST";
always @(posedge CLK) begin
    if(process_valid===1'bx) begin
        $display("Valid bit can't be x! Module '%s' function 'process'", INSTANCE_NAME);
    end
end
reg [7:0] SR_x0_y0;
reg [7:0] SR_x1_y0;
reg [7:0] SR_x2_y0;
reg [7:0] SR_x3_y0;
reg [7:0] SR_x4_y0;
reg [7:0] SR_x5_y0;
wire [7:0] unnamedcast3738USEDMULTIPLEcast;
assign unnamedcast3738USEDMULTIPLEcast = ({inp[7:0]});
wire [7:0] unnamedcast3736USEDMULTIPLEcast;
assign unnamedcast3736USEDMULTIPLEcast = ({inp[15:8]});
reg [7:0] SR_x0_y1;
reg [7:0] SR_x1_y1;
reg [7:0] SR_x2_y1;
reg [7:0] SR_x3_y1;
reg [7:0] SR_x4_y1;
reg [7:0] SR_x5_y1;
wire [7:0] unnamedcast3762USEDMULTIPLEcast;
assign unnamedcast3762USEDMULTIPLEcast = ({inp[23:16]});
wire [7:0] unnamedcast3760USEDMULTIPLEcast;
assign unnamedcast3760USEDMULTIPLEcast = ({inp[31:24]});
reg [7:0] SR_x0_y2;
reg [7:0] SR_x1_y2;
reg [7:0] SR_x2_y2;
reg [7:0] SR_x3_y2;
reg [7:0] SR_x4_y2;
reg [7:0] SR_x5_y2;
wire [7:0] unnamedcast3786USEDMULTIPLEcast;
assign unnamedcast3786USEDMULTIPLEcast = ({inp[39:32]});
wire [7:0] unnamedcast3784USEDMULTIPLEcast;
assign unnamedcast3784USEDMULTIPLEcast = ({inp[47:40]});
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x5_y0 <= unnamedcast3736USEDMULTIPLEcast;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x4_y0 <= unnamedcast3738USEDMULTIPLEcast;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x3_y0 <= SR_x5_y0;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x2_y0 <= SR_x4_y0;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x1_y0 <= SR_x3_y0;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x0_y0 <= SR_x2_y0;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x5_y1 <= unnamedcast3760USEDMULTIPLEcast;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x4_y1 <= unnamedcast3762USEDMULTIPLEcast;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x3_y1 <= SR_x5_y1;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x2_y1 <= SR_x4_y1;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x1_y1 <= SR_x3_y1;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x0_y1 <= SR_x2_y1;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x5_y2 <= unnamedcast3784USEDMULTIPLEcast;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x4_y2 <= unnamedcast3786USEDMULTIPLEcast;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x3_y2 <= SR_x5_y2;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x2_y2 <= SR_x4_y2;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x1_y2 <= SR_x3_y2;
    end
end
always @ (posedge CLK) begin
    if (process_valid && process_CE) begin
        SR_x0_y2 <= SR_x2_y2;
    end
end
assign process_output = {
    unnamedcast3784USEDMULTIPLEcast, unnamedcast3786USEDMULTIPLEcast, SR_x5_y2, SR_x4_y2, SR_x3_y2, SR_x2_y2, SR_x1_y2, SR_x0_y2,
    unnamedcast3760USEDMULTIPLEcast, unnamedcast3762USEDMULTIPLEcast, SR_x5_y1, SR_x4_y1, SR_x3_y1, SR_x2_y1, SR_x1_y1, SR_x0_y1,
    unnamedcast3736USEDMULTIPLEcast, unnamedcast3738USEDMULTIPLEcast, SR_x5_y0, SR_x4_y0, SR_x3_y0, SR_x2_y0, SR_x1_y0, SR_x0_y0
};
endmodule
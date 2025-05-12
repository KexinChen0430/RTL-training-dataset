module SST39VF200A(
    A15, A14, A13, A12, A11, A10, A9, A8, NC1, NC2, WE_n, NC3, NC4, NC5, NC6, NC7, NC8, A7, A6, A5, A4, A3, A2, A1, A0,
    CE_n, VSS1, OE_n,
    DQ0, DQ8, DQ1, DQ9, DQ2, DQ10, DQ3, DQ11, VDD, DQ4, DQ12, DQ5, DQ13, DQ6, DQ14, DQ7, DQ15,
    VSS2, NC9, A16,
    SIM_RST, SIM_CLK
`ifdef TARGET_FPGA
    , EPCS_DATA, EPCS_CSN, EPCS_DCLK, EPCS_ASDI
`endif
);
input wire SIM_RST;
input wire SIM_CLK;
`ifdef TARGET_FPGA
    input wire EPCS_DATA; 
    output reg EPCS_CSN = 1'b1; 
    output reg EPCS_DCLK = 1'b1; 
    output reg EPCS_ASDI = 1'b0; 
    localparam DESELECTED=2'd0; 
    localparam SET=2'd1; 
    localparam RESET=2'd2; 
    localparam HOLD=2'd3; 
    reg [1:0] state = DESELECTED;
    reg [39:0] cmd;
    reg [5:0] ctr;
    reg [15:0] sensed_word;
    reg cmd_complete = 1'b0;
`endif
input wire VDD;
input wire VSS1;
input wire VSS2;
input wire CE_n;
input wire OE_n;
input wire WE_n;
input wire A0;
input wire A1;
input wire A2;
input wire A3;
input wire A4;
input wire A5;
input wire A6;
input wire A7;
input wire A8;
input wire A9;
input wire A10;
input wire A11;
input wire A12;
input wire A13;
input wire A14;
input wire A15;
input wire A16;
output wire DQ0;
output wire DQ1;
output wire DQ2;
output wire DQ3;
output wire DQ4;
output wire DQ5;
output wire DQ6;
output wire DQ7;
output wire DQ8;
output wire DQ9;
output wire DQ10;
output wire DQ11;
output wire DQ12;
output wire DQ13;
output wire DQ14;
output wire DQ15;
input wire NC1;
input wire NC2;
input wire NC3;
input wire NC4;
input wire NC5;
input wire NC6;
input wire NC7;
input wire NC8;
input wire NC9;
reg [15:0] data;
assign DQ0 = data[0];
assign DQ1 = data[1];
assign DQ2 = data[2];
assign DQ3 = data[3];
assign DQ4 = data[4];
assign DQ5 = data[5];
assign DQ6 = data[6];
assign DQ7 = data[7];
assign DQ8 = data[8];
assign DQ9 = data[9];
assign DQ10 = data[10];
assign DQ11 = data[11];
assign DQ12 = data[12];
assign DQ13 = data[13];
assign DQ14 = data[14];
assign DQ15 = data[15];
wire [16:0] addr;
`ifdef TARGET_FPGA
    assign addr =
`else
    assign #40 addr =
`endif
         {A16, A15, A14, A13, A12, A11, A10, A9, A8, A7, A6, A5, A4, A3, A2, A1, A0};
`ifdef TARGET_FPGA
    always @(posedge SIM_CLK)
    begin
        case(state)
        endcase
        if (OE_n == 1'b0) begin
            data = sensed_word;
        end else begin
            data = 15'b0;
        end
    end
`else
    always @(CE_n, OE_n, addr)
    begin
        if (!CE_n && !OE_n)
        begin
            case (addr)
                `include "roms/rom.v"
                default: data = 16'hFFFF;
            endcase
        end
        else
        begin
            data = 16'bZ;
        end
    end
`endif
endmodule
module fabric2_mswitch #(
    parameter PORTNO_WIDTH = 11 
)
(
    i_portno, 
    i_ID_MAddr, i_ID_MCmd, i_ID_MData, i_ID_MByteEn, o_ID_SCmdAccept, o_ID_SData, o_ID_SResp,
    o_P0_MAddr, o_P0_MCmd, o_P0_MData, o_P0_MByteEn, i_P0_SCmdAccept, i_P0_SData, i_P0_SResp,
    o_P1_MAddr, o_P1_MCmd, o_P1_MData, o_P1_MByteEn, i_P1_SCmdAccept, i_P1_SData, i_P1_SResp,
    o_P2_MAddr, o_P2_MCmd, o_P2_MData, o_P2_MByteEn, i_P2_SCmdAccept, i_P2_SData, i_P2_SResp,
    o_P3_MAddr, o_P3_MCmd, o_P3_MData, o_P3_MByteEn, i_P3_SCmdAccept, i_P3_SData, i_P3_SResp,
    o_P4_MAddr, o_P4_MCmd, o_P4_MData, o_P4_MByteEn, i_P4_SCmdAccept, i_P4_SData, i_P4_SResp
);
input wire [PORTNO_WIDTH-1:0] i_portno; 
input wire [`ADDR_WIDTH-1:0] i_ID_MAddr; 
input wire [2:0] i_ID_MCmd; 
input wire [`DATA_WIDTH-1:0] i_ID_MData; 
input wire [`BEN_WIDTH-1:0] i_ID_MByteEn; 
output reg o_ID_SCmdAccept; 
output reg [`DATA_WIDTH-1:0] o_ID_SData; 
output reg [1:0] o_ID_SResp; 
always @(*)
begin
    o_ID_SCmdAccept = 1'b0;
    o_ID_SData = { (`DATA_WIDTH){1'b0} };
    o_ID_SResp = 2'b00;
    case(i_portno)
        'd1: begin
            o_P1_MAddr = i_ID_MAddr;
            o_P1_MCmd = i_ID_MCmd;
            o_P1_MData = i_ID_MData;
            o_P1_MByteEn = i_ID_MByteEn;
            o_ID_SCmdAccept = i_P1_SCmdAccept;
            o_ID_SData = i_P1_SData;
            o_ID_SResp = i_P1_SResp;
        end
        default: begin
            o_P0_MAddr = i_ID_MAddr;
            o_P0_MCmd = i_ID_MCmd;
            o_P0_MData = i_ID_MData;
            o_P0_MByteEn = i_ID_MByteEn;
            o_ID_SCmdAccept = i_P0_SCmdAccept;
            o_ID_SData = i_P0_SData;
            o_ID_SResp = i_P0_SResp;
        end
    endcase
end
endmodule
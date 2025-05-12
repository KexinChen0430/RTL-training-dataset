module fabric_port_demux(
    i_select,
    i_I_MAddr,
    i_I_MCmd,
    i_I_MData,
    i_I_MByteEn,
    o_I_SCmdAccept,
    o_I_SData,
    o_I_SResp,
    i_D_MAddr,
    i_D_MCmd,
    i_D_MData,
    i_D_MByteEn,
    o_D_SCmdAccept,
    o_D_SData,
    o_D_SResp,
    o_P_MAddr,
    o_P_MCmd,
    o_P_MData,
    o_P_MByteEn,
    i_P_SCmdAccept,
    i_P_SData,
    i_P_SResp
);
input wire i_select;
input wire [`ADDR_WIDTH-1:0] i_I_MAddr;      
input wire [2:0] i_I_MCmd;                   
input wire [`DATA_WIDTH-1:0] i_I_MData;      
input wire [`BEN_WIDTH-1:0] i_I_MByteEn;     
output reg o_I_SCmdAccept;                   
output reg [`DATA_WIDTH-1:0] o_I_SData;      
output reg [1:0] o_I_SResp;                  
input wire [`ADDR_WIDTH-1:0] i_D_MAddr;      
input wire [2:0] i_D_MCmd;                   
input wire [`DATA_WIDTH-1:0] i_D_MData;      
input wire [`BEN_WIDTH-1:0] i_D_MByteEn;     
output reg o_D_SCmdAccept;                   
output reg [`DATA_WIDTH-1:0] o_D_SData;      
output reg [1:0] o_D_SResp;                  
output reg [`ADDR_WIDTH-1:0] o_P_MAddr;      
output reg [2:0] o_P_MCmd;                   
output reg [`DATA_WIDTH-1:0] o_P_MData;      
output reg [`BEN_WIDTH-1:0] o_P_MByteEn;     
input wire i_P_SCmdAccept;                   
input wire [`DATA_WIDTH-1:0] i_P_SData;      
input wire [1:0] i_P_SResp;                  
always @(*)
begin
    if(i_select)
    begin
        o_P_MAddr = i_I_MAddr;               
        o_P_MCmd = i_I_MCmd;                 
        o_P_MData = i_I_MData;               
        o_P_MByteEn = i_I_MByteEn;           
        o_I_SCmdAccept = i_P_SCmdAccept;     
        o_I_SData = i_P_SData;               
        o_I_SResp = i_P_SResp;               
        o_D_SCmdAccept = 1'b0;               
        o_D_SData = { (`DATA_WIDTH){1'b0} }; 
        o_D_SResp = 2'b00;                   
    end
    else
    begin
        o_P_MAddr = i_D_MAddr;               
        o_P_MCmd = i_D_MCmd;                 
        o_P_MData = i_D_MData;               
        o_P_MByteEn = i_D_MByteEn;           
        o_I_SCmdAccept = 1'b0;               
        o_I_SData = { (`DATA_WIDTH){1'b0} }; 
        o_I_SResp = 2'b00;                   
        o_D_SCmdAccept = i_P_SCmdAccept;     
        o_D_SData = i_P_SData;               
        o_D_SResp = i_P_SResp;               
    end
end
endmodule
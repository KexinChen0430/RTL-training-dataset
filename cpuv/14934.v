module system_dlmb_v10_0(
    LMB_Clk, 
    SYS_Rst, 
    LMB_Rst, 
    M_ABus, 
    M_ReadStrobe, 
    M_WriteStrobe, 
    M_AddrStrobe, 
    M_DBus, 
    M_BE, 
    Sl_DBus, 
    Sl_Ready, 
    Sl_Wait, 
    Sl_UE, 
    Sl_CE, 
    LMB_ABus, 
    LMB_ReadStrobe, 
    LMB_WriteStrobe, 
    LMB_AddrStrobe, 
    LMB_ReadDBus, 
    LMB_WriteDBus, 
    LMB_Ready, 
    LMB_Wait, 
    LMB_UE, 
    LMB_CE, 
    LMB_BE 
);
;
input LMB_Clk; 
input SYS_Rst; 
output LMB_Rst; 
input [0:31]M_ABus; 
input M_ReadStrobe; 
input M_WriteStrobe; 
input M_AddrStrobe; 
input [0:31]M_DBus; 
input [0:3]M_BE; 
input [0:31]Sl_DBus; 
input [0:0]Sl_Ready; 
input [0:0]Sl_Wait; 
input [0:0]Sl_UE; 
input [0:0]Sl_CE; 
output [0:31]LMB_ABus; 
output LMB_ReadStrobe; 
output LMB_WriteStrobe; 
output LMB_AddrStrobe; 
output [0:31]LMB_ReadDBus; 
output [0:31]LMB_WriteDBus; 
output LMB_Ready; 
output LMB_Wait; 
output LMB_UE; 
output LMB_CE; 
output [0:3]LMB_BE; 
endmodule
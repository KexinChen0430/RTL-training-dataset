module System_Memory( 
	input  clock, 
    input  reset, 
    input  Inst_Read_in, 
    input  [3:0]  Inst_Write_in, 
    input  [29:0] Inst_Address_in, 
    input  [31:0] Inst_Data_in, 
    output [31:0] Inst_Data_out, 
    output Inst_Ready_out, 
	input  flush, 
	output flushcomplete, 
    input  Data_Read_in, 
    input  [3:0]  Data_Write_in, 
    input  [29:0] Data_Address_in, 
    input  [31:0] Data_Data_in, 
    output [31:0] Data_Data_out, 
    output Data_Ready_out, 
    output Init_Mem_out, 
    input MISO, 
    output MOSI, 
    output CSn, 
    output SClk, 
    output [4:0] CurrentState 
    );
	wire [29:0] Inst_Address; 
	wire Inst_Write, Inst_Read, Inst_Ready; 
	wire [4095:0] Inst_Data_i, Inst_Data_o; 
	wire [29:0] Data_Address; 
	wire Data_Write, Data_Read, Data_Ready; 
	wire [4095:0] Data_Data_i, Data_Data_o; 
	wire [29:0] SD_Address; 
    wire SD_Write, SD_Read, SD_Ready; 
    wire [4095:0] SD_Data_i, SD_Data_o; 
	Level_1_Cache ICache( 
		);
	Level_1_Cache DCache( 
		);
	Bus_Arbiter BUS( 
        );
	SD_Module_Interface SD( 
        );
endmodule
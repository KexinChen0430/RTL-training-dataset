module WcaPortNull(
    inout  [31:0]  						pifData,		
    input  wire [(NBITS_ADDR+2):0] 	portCtrl, 	
    output wire [1:0]				  	portCmd  	
);
parameter ADDR_PORT = 0;      
parameter NBITS_ADDR = 2;     
wire   isAddr  = (ADDR_PORT == portCtrl[NBITS_ADDR+2:3]); 
assign portCmd =  (isAddr ) ? `PIFCMD_IDLE : 2'bz; 
endmodule 
parameter WAIT_CNT_SIZE=11; 
input clk, sigIn; 
input [WAIT_CNT_SIZE-1:0] waitCnt; 
output wire sigOut; 
reg sigOutReg, sigInLast; 
reg [WAIT_CNT_SIZE-1:0] timer; 
module scheduler1_multi(
    clk, reset, wen, enablein, datain, dataout, full, empty, enableout
);
parameter data_width = 32;       
parameter data_width1 = 36;      
parameter address_width = 7;     
parameter FIFO_depth = 128;      
parameter number_mapper = 2;     
input clk, reset, wen, enablein; 
input [data_width-1:0] datain;   
output [data_width1-1:0] dataout;
output full, empty;               
output enableout;                 
reg [address_width-1:0] write_p, read_p; 
reg [address_width:0] counter;           
reg [data_width-1:0] dataout1;           
wire [data_width1-1:0] dataout;          
reg [data_width-1:0] memory[FIFO_depth-1:0]; 
reg [data_width-1:0] keywordnumber, textfilenumber; 
reg enableout1;                           
reg [3:0] routeraddress;                  
reg wen1;                                 
reg [data_width-1:0] datain1;             
reg ren;                                  
reg [5:0] counter2, counter1, counter3, counter4; 
reg [3:0] mapper_p;                       
assign full = (counter == (FIFO_depth-1)); 
assign empty = (counter == 0);             
assign dataout[35:4] = dataout1;           
assign dataout[3:0] = routeraddress;       
assign enableout = enableout1;             
endmodule
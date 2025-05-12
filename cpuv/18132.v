module my_avalon_mm(
    clk,            
    write,          
    address,        
    writedata,      
    readdata        
);
input clk, write;                          
input [`MAX_ADDR-1:0] address;             
input [7:0] writedata;                     
output reg [7:0] readdata;                 
reg [7:0] mem [127:0];                     
always @(posedge clk) begin                
    if (write)                             
        mem[address] <= writedata;         
    readdata <= mem[address];              
end                                        
endmodule                                  
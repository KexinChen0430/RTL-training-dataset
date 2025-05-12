module dummy7; 
`define ADDR1 16'h0011 
`define ADDR2 16'h0022 
`define ADDR81 8'h11 
`define ADDR82 8'h22 
reg [7:0] data1; 
reg [7:0] data2; 
reg [7:0] data3; 
reg [7:0] data4; 
reg [7:0] addr; 
reg [15:0] addr16; 
always @ (addr) 
case (addr) 
`ADDR1    %256  : data1 = 8'h11; 
`ADDR2    %256  : data1 = 8'h22; 
default         : data1 = 8'h00; 
endcase
always @ (addr) 
case (addr) 
`ADDR1          : data2 = 8'h11; 
`ADDR2          : data2 = 8'h22; 
default         : data2 = 8'h00; 
endcase
always @ (addr16) 
case (addr16) 
`ADDR1          : data3 = 8'h11; 
`ADDR2          : data3 = 8'h22; 
default         : data3 = 8'h00; 
endcase
always @ (addr) 
case (addr) 
`ADDR81         : data4 = 8'h11; 
`ADDR82         : data4 = 8'h22; 
default         : data4 = 8'h00; 
endcase
initial 
begin
addr   =  8'h00; 
addr16 = 16'h0000; 
#10; 
$display("should be 00 -- data1=%h  data2=%h  data3=%h  data4=%h\n",data1,data2,data3,data4); 
addr   =  8'h11; 
addr16 = 16'h0011; 
#10; 
$display("should be 11 -- data1=%h  data2=%h  data3=%h  data4=%h\n",data1,data2,data3,data4); 
addr   =  8'h22; 
addr16 = 16'h0022; 
#10; 
$display("should be 22 -- data1=%h  data2=%h  data3=%h  data4=%h\n",data1,data2,data3,data4); 
$finish; 
end
endmodule 
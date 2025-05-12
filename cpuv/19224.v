module counter(clk, rst, enable, count); 
input clk, rst, enable; 
output [3:0] count; 
reg [3:0] count; 
always @ (posedge clk or posedge rst) 
if (rst) begin 
	count <= 0; 
end else begin: COUNT 
	while (enable) begin 
		count <= count + 1 
		disable COUNT; 
	end
end
always @(a or b or sel) 
begin
	y = 0;  
	if (sel == 0) begin 
		y = a; 
	end
	else begin 
		y = b; 
	end
end
always @ (posedge clk) 
if (reset == 0) begin 
	y <= 0; 
end
else if (sel == 0) begin 
	y <= a; 
end
else begin 
	y <= b; 
end
endmodule 
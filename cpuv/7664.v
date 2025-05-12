module random_access_memory#(parameter n=1, parameter m=1)(clk,address,MDR_line,enable,clr,rw); 
parameter L = (2**n); 
integer i; 
input clk, enable,clr,rw; 
input [n-1:0]address; 
inout [m-1:0]MDR_line; 
reg [m-1:0]MEM [L-1:0]; 
initial begin
end 
always @(posedge clk) 
begin
	if (clr == 1) begin 
		for(i=0;i<L;i=i+1) begin 
			MEM[i] <= 0; 
		end
	end
	else if(enable && rw) begin 
		MEM[address] <= MDR_line; 
	end
	else if(enable && ~rw) begin 
	end
	else begin
	end
end
assign MDR_line = (enable && ~rw) ? MEM[address] : 16'hZZ; 
endmodule
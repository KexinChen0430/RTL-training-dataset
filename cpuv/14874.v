module counter(clk,sigIn,n_clk);
/***
Single-period counter - counts number of clock cycles between signal edges.
Ted Golfinopoulos, 19 Sep 2012
parameter N_CLK_SIZE=8;
input clk, sigIn;
output [N_CLK_SIZE-1:0] n_clk;
reg [N_CLK_SIZE-1:0] n_clk_reg, n_clk_reg_last;
reg clkResetFlag;
reg sigLast;
initial begin
	#0
	sigLast=1'b0;
	n_clk_reg=1'b0;
	n_clk_reg_last=1'b0;
	clkResetFlag=1'b1;
end
always @(posedge clk) begin
	if( sigIn>sigLast ) begin 
		n_clk_reg_last=n_clk_reg;
		clkResetFlag=1'b1;
		sigLast=sigIn;
	end else if(sigIn<sigLast) begin 
		sigLast=sigIn;
	end else if(clkResetFlag) begin
		n_clk_reg=1'b1; 
		clkResetFlag=1'b0; 
	end else begin
		n_clk_reg=n_clk_reg+1'b1; 
	end
end
assign n_clk=n_clk_reg_last; 
endmodule
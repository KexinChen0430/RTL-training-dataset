module or1200_gmultp2_32x32 ( X, Y, CLK, RST, P );
input   [`OR1200_W-1:0]  X;
input   [`OR1200_W-1:0]  Y;
input           CLK;
input           RST;
output  [`OR1200_WW-1:0]  P;
reg     [`OR1200_WW-1:0]  p0;
reg     [`OR1200_WW-1:0]  p1;
integer 		  xi;
integer 		  yi;
always @(X)
	xi <= X;
always @(Y)
	yi <= Y;
always @(posedge CLK or posedge RST)
        if (RST)
                p0 <= `OR1200_WW'b0;
        else
                p0 <= #1 xi * yi;
always @(posedge CLK or posedge RST)
        if (RST)
                p1 <= `OR1200_WW'b0;
        else
                p1 <= #1 p0;
assign P = p1;
endmodule
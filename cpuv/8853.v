module uparc_long_idiv(
	clk,
	nrst,
	dividend,
	divider,
	start,
	signd,
	ready,
	remquot
);
input wire				clk;
input wire				nrst;
input wire [`UPARC_REG_WIDTH-1:0]	dividend;
input wire [`UPARC_REG_WIDTH-1:0]	divider;
input wire				start;
input wire				signd;
output wire				ready;
output wire [2*`UPARC_REG_WIDTH-1:0]	remquot;
reg [2*`UPARC_REG_WIDTH-1:0]	qr;
reg [5:0]			nbit;
wire [`UPARC_REG_WIDTH:0]	diff;
reg [`UPARC_REG_WIDTH-1:0]	abs_divider;
assign ready	= !(|nbit) && !start;
assign remquot[2*`UPARC_REG_WIDTH-1:`UPARC_REG_WIDTH]	=
			(signd && dividend[`UPARC_REG_WIDTH-1]) ?
				-qr[2*`UPARC_REG_WIDTH-1:`UPARC_REG_WIDTH] :
				qr[2*`UPARC_REG_WIDTH-1:`UPARC_REG_WIDTH];
assign remquot[`UPARC_REG_WIDTH-1:0]			=
			(signd && (dividend[`UPARC_REG_WIDTH-1] ^ divider[`UPARC_REG_WIDTH-1])) ?
				-qr[`UPARC_REG_WIDTH-1:0] : qr[`UPARC_REG_WIDTH-1:0];
assign diff	= qr[2*`UPARC_REG_WIDTH-1:`UPARC_REG_WIDTH-1] - { 1'b0, abs_divider };
always @(posedge clk or negedge nrst)
begin
	if(!nrst)
	begin
		qr <= {(2*`UPARC_REG_WIDTH){1'b0}};
		nbit <= 6'b0;
		abs_divider <= {(`UPARC_REG_WIDTH){1'b0}};
	end
	else if(start)
	begin
		if(!(|dividend) || !(|divider))
		begin
			qr <= {(2*`UPARC_REG_WIDTH){1'b0}};
			nbit <= 6'b0;
		end
		else
		begin
			nbit <= 6'd`UPARC_REG_WIDTH;
			qr <= { {(`UPARC_REG_WIDTH){1'b0}}, signd && dividend[`UPARC_REG_WIDTH-1] ?
					-dividend : dividend };
			abs_divider <= signd && divider[`UPARC_REG_WIDTH-1] ? -divider : divider;
		end
	end
	else if(|nbit)
	begin
		nbit <= nbit - 1'b1;
		if(diff[`UPARC_REG_WIDTH])
			qr <= { qr[2*`UPARC_REG_WIDTH-2:0], 1'b0 };
		else
			qr <= { diff[`UPARC_REG_WIDTH-1:0], qr[`UPARC_REG_WIDTH-2:0], 1'b1 };
	end
end
endmodule
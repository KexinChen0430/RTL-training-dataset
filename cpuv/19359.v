module CIRCULAR_SHIFTLEFT_POSEDGE_EX # ( parameter SIZE=`WIDTH )
( input wire Clock,
  input wire Reset,
  input wire[SIZE-1:0] Initial,
  input wire      Enable,
  output wire[SIZE-1:0] O
);
reg [SIZE-1:0] tmp;
  always @(posedge Clock)
  begin
  if (Reset)
		tmp <= Initial;
	else
	begin
		if (Enable)
		begin
			if (tmp[SIZE-1])
			begin
				tmp <= Initial;
			end
			else
			begin
				tmp <= tmp << 1;
			end
		end
	end
  end
    assign O  = tmp;
endmodule
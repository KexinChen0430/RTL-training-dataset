module multiplicadorPuntoFijo  #(parameter Width = 24, Magnitud = 4, Precision = 19, Signo = 1)
		(EnableMul,In,Coeff,OutMul,Error);
	 input EnableMul;
	 input signed [Width-1:0] In,Coeff;
	 output reg signed [Width-1:0] OutMul = 0;
	 output Error;
	 reg signed [2*Width-1:0]  AuxMul = 0;
	 reg Overflow = 0;
	 reg Underflow = 0;
	always @* begin 
		if (EnableMul) begin
			AuxMul <= In * Coeff; 
		end
		else begin
			AuxMul <= 0;
		end
	end
	always @* begin 
	always @* begin 
		if (In == 0 || Coeff==0) begin
			OutMul <= 0;
		end
		else begin
	assign Error =  Overflow | Underflow;
endmodule
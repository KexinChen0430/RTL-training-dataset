module's undeclared outputs)
   reg			bra;        
   reg [15:0]		ireg;      
   reg [3:0]		opc;       
   reg [1:0]		pha;       
   reg [2:0]		rra;       
   reg [2:0]		rwa;       
   reg			rwe;       
   wire [5:0] 		decA, decB; 
   wire [3:0] 		decO;       
   assign {decB, decA, decO} = ireg; 
   wire 		nop = 16'd1; 
   wire 		_skp = (decO == 4'h0); 
   wire 		Fbra = (ireg[4:0] == 5'h10); 
   always @(posedge clk)
     if (rst) begin
	pha <= 2'h0;
     end else if (ena) begin
	pha <= pha + 1;
     end
   always @(posedge clk)
     if (rst) begin
	ireg <= 16'h0;
	opc <= 4'h0;
     end else if (ena) begin
	case (pha)
	  2'o2: ireg <= (wpc | Fbra) ? nop : f_dti; 
	  default: ireg <= ireg; 
	endcase
	case (pha)
	  2'o2: opc <= ireg[3:0]; 
	  default: opc <= opc; 
	endcase
     end
   reg _bra; 
   always @(posedge clk)
     if (rst) begin
	_bra <= 1'h0;
	bra <= 1'h0;
     end else if (ena) begin
	case (pha)
	  2'o0: {bra, _bra} <= {_bra & CC, (ireg[5:0] == 5'h10)}; 
	  default: {bra, _bra} <= {1'b0, _bra}; 
	endcase
     end
   reg [2:0] _rwa; 
   reg 	     _rwe; 
   always @(posedge clk)
     if (rst) begin
	_rwa <= 3'h0;
	_rwe <= 1'h0;
	rra <= 3'h0;
	rwa <= 3'h0;
	rwe <= 1'h0;
     end else if (ena) begin
	case (pha)
	  2'o3: rra <= decA[2:0]; 
	  2'o1: rra <= decA[2:0]; 
	  2'o2: rra <= decB[2:0]; 
	  2'o0: rra <= decB[2:0]; 
	endcase
	case (pha)
	  2'o0: {rwe} <= _rwe & CC & (opc[3:2] != 2'o3); 
	  default: {rwe} <= {1'b0}; 
	endcase
	case (pha)
	  2'o1: {rwa} <= {_rwa}; 
	  default: {rwa} <= {rwa}; 
	endcase
	case (pha)
	  2'o0: begin
	     _rwa <= decA[2:0]; 
	     _rwe <= (decA[5:3] == 3'o0) & !_skp; 
	  end
	  default: {_rwa, _rwe} <= {_rwa, _rwe}; 
	endcase
     end
endmodule
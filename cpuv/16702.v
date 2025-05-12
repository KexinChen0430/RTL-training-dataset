module selected for read-write operations from ports.v
	input write_strobe; 
	input [1:0] regsel; 
      output reg [20:0] dma_addr; 
      output reg  [7:0] dma_wd; 
      input       [7:0] dma_rd; 
      output reg        dma_rnw; 
      output reg dma_req; 
      input      dma_ack; 
      input      dma_done; 
);
	wire zxrd,zxwr; 
	reg zxoldrd,zxoldwr; 
	reg zxclr; 
	reg [2:0] zxrdtgl, zxwrtgl; 
	localparam _HAD = 2'b00; 
	localparam _MAD = 2'b01; 
	localparam _LAD = 2'b10; 
	localparam _CST = 2'b11; 
	always @*
	case( regsel[1:0] )
		_HAD: dout = { 3'b000, dma_addr[20:16] }; 
		_MAD: dout = dma_addr[15:8]; 
		_LAD: dout = dma_addr[7:0]; 
		_CST: dout = { dma_on, 7'bXXXXXXX }; 
	endcase
	always @(posedge clk, negedge rst_n)
	if( !rst_n ) 
	begin
		dma_on <= 1'b0;
	end
	else 
	begin
		if( module_select && write_strobe && (regsel==_CST) )
			dma_on <= din[7]; 
		if( dma_ack && dma_on )
			dma_addr <= dma_addr + 20'd1; 
		else if( module_select && write_strobe ) 
		begin
			if( regsel==_HAD )
				dma_addr[20:16] <= din[4:0]; 
			else if( regsel==_MAD )
				dma_addr[15:8]  <= din[7:0]; 
			else if( regsel==_LAD )
				dma_addr[7:0]   <= din[7:0]; 
		end
	end
	always @(posedge clk,negedge rst_n)
	if( !rst_n ) 
	begin
		zxoldrd <= 1'b0;
		zxoldwr <= 1'b0;
	end
	else 
	begin
		if( dma_on ) 
		begin
			if( zxrdtgl[2] != zxrdtgl[1] )
				zxoldrd <= 1'b1; 
			else if( zxclr )
				zxoldrd <= 1'b0; 
			if( zxwrtgl[2] != zxwrtgl[1] )
				zxoldwr <= 1'b1; 
			else if( zxclr )
				zxoldwr <= 1'b0; 
		end
		else 
		begin
			zxoldrd <= 1'b0;
			zxoldwr <= 1'b0;
		end
	end
	always @(posedge clk)
	begin
		zxrdtgl[2:0] <= { zxrdtgl[1:0], dma_zxread_toggle  }; 
		zxwrtgl[2:0] <= { zxwrtgl[1:0], dma_zxwrite_toggle }; 
	end
	assign zxrd = ( zxrdtgl[2] != zxrdtgl[1] ) | zxoldrd; 
	assign zxwr = ( zxwrtgl[2] != zxwrtgl[1] ) | zxoldwr; 
endmodule
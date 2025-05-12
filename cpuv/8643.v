module mouse 
(
	input        clk_sys, 
	input        reset, 
	input [24:0] ps2_mouse, 
	input  [2:0] addr, 
	output       sel, 
	output [7:0] dout 
);
assign dout = data; 
assign sel  = port_sel; 
reg   [1:0] button;
reg         mbutton;
reg  [11:0] dx;
reg  [11:0] dy;
wire [11:0] newdx = dx + {{4{ps2_mouse[4]}},ps2_mouse[15:8]};
wire [11:0] newdy = dy + {{4{ps2_mouse[5]}},ps2_mouse[23:16]};
reg   [1:0] swap;
reg   [7:0] data;
reg         port_sel;
always @* begin
	port_sel = 1; 
	casex(addr) 
		 3'b011: data = dx[7:0]; 
		 3'b111: data = dy[7:0]; 
		 3'bX10: data = ~{5'b00000,mbutton, button[swap[1]], button[~swap[1]]} ; 
		default: {port_sel,data} = 8'hFF; 
	endcase
end
always @(posedge clk_sys) begin
	reg       old_status;
	old_status <= ps2_mouse[24]; 
	if(reset) begin 
		dx     <= 128; 
		dy     <= 0; 
		button <= 0; 
		swap   <= 0; 
	end else begin
		if(old_status != ps2_mouse[24]) begin 
			if(!swap) swap <= ps2_mouse[1:0]; 
			{mbutton,button} <= ps2_mouse[2:0]; 
			dx <= newdx; 
			dy <= newdy; 
		end
	end
end
endmodule
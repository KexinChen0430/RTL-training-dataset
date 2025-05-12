module ShiftReg16(
	input clk, 
	input shiftBypass, 
	input signed [15:0] din, 
	input [4:0] tap, 
	(* shreg_extract = "no" *) output reg signed [15:0] dout = 16'd0 
);
parameter SRL_SIZE = 32; 
(* shreg_extract = "yes" *) reg [15:0] dsh_in [0:SRL_SIZE-3];
(* shreg_extract = "no" *) reg [4:0] tap_b = 5'd0;
(* shreg_extract = "no" *) reg shiftBypass_b = 1'b1;
integer n; 
`ifdef XILINX_ISIM
integer i;
initial for (i=0; i < (SRL_SIZE-2); i=i+1) dsh_in[i]=16'd0; 
`endif
always @(posedge clk) begin
	shiftBypass_b <= shiftBypass; 
	tap_b <= (tap < 5'd2) ? 5'd0 : (tap - 5'd2); 
	dsh_in[0] <= din; 
	for (n=SRL_SIZE-3; n > 0; n=n-1) dsh_in[n] <= dsh_in[n-1]; 
	dout <= (shiftBypass_b) ? din : dsh_in[tap_b]; 
end
endmodule
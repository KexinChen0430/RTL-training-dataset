module ShiftReg( 
	input clk, 
	input sr_bypass, 
	input signed [12:0] din, 
	input [4:0] tap, 
	(* shreg_extract = "no" *) output reg signed [12:0] dout = 13'sd0 
);
parameter SRL_SIZE = 32; 
parameter INIT = 13'sd0; 
(* shreg_extract = "yes" *) reg signed [12:0] dsh_in [0:SRL_SIZE-3]; 
(* equivalent_register_removal = "no" *) reg [4:0] tap_b = 5'd2; 
(* shreg_extract = "no" *) reg sr_bypass_b = 1'b1; 
integer n; 
`ifdef XILINX_ISIM 
integer i; 
initial for (i=0; i < (SRL_SIZE-3); i=i+1) dsh_in[i]= 13'sd0; 
`endif
always @(posedge clk) begin 
	sr_bypass_b <= sr_bypass; 
	tap_b <= (tap < 5'd2) ? 5'd0 : (tap - 5'd2); 
	dsh_in[0] <= din; 
	for (n=SRL_SIZE-3; n > 0; n=n-1) dsh_in[n] <= dsh_in[n-1]; 
	dout <= (sr_bypass_b) ? din : dsh_in[tap_b]; 
end
endmodule
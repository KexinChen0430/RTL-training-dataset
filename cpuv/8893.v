module altqpram ( 
	wraddress_a, 
	inclocken_a, 
	wraddress_b, 
	wren_a, 
	inclocken_b, 
	wren_b, 
	inaclr_a, 
	inaclr_b, 
	inclock_a, 
	inclock_b, 
	data_a, 
	data_b, 
	q_a, 
	q_b 
);
parameter width_write_a = 8; 
parameter widthad_write_a = 11; 
parameter width_write_b = 8; 
parameter widthad_write_b = 11; 
localparam dw = width_write_a; 
localparam aw = widthad_write_a; 
input inclock_a, inaclr_a, inclocken_a, wren_a, inclock_b, inaclr_b, inclocken_b, wren_b; 
input [dw-1:0] data_a, data_b; 
output [dw-1:0] q_a, q_b; 
input [aw-1:0] wraddress_a, wraddress_b; 
reg	[dw-1:0]	mem [(1<<aw)-1:0];	
reg	[aw-1:0]	addr_reg_a;		
reg	[aw-1:0]	addr_reg_b;		
assign q_a = mem[addr_reg_a][dw-1:0]; 
assign q_b = mem[addr_reg_b][dw-1:0]; 
always @(posedge inclock_a or posedge inaclr_a) 
    if ( inaclr_a == 1'b1 ) 
        addr_reg_a <= #1 {aw{1'b0}}; 
    else if ( inclocken_a ) 
        addr_reg_a <= #1 wraddress_a; 
always @(posedge inclock_b or posedge inaclr_b) 
    if ( inaclr_b == 1'b1 ) 
        addr_reg_b <= #1 {aw{1'b0}}; 
    else if ( inclocken_b ) 
        addr_reg_b <= #1 wraddress_b; 
always @(posedge inclock_a) 
	if (inclocken_a && wren_a) 
		mem[wraddress_a] <= #1 data_a; 
always @(posedge inclock_b) 
	if (inclocken_b && wren_b) 
		mem[wraddress_b] <= #1 data_b; 
endmodule 
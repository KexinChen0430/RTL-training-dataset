module tracking_camera_system_altpll_0_dffpipe_l2c
(
    clock,  
    clrn,   
    d,      
    q       
) ; 
input clock;  
input clrn;   
input [0:0] d; 
output [0:0] q; 
`ifndef ALTERA_RESERVED_QIS
`endif
tri0 clock; 
tri1 clrn;  
`ifndef ALTERA_RESERVED_QIS
`endif
reg [0:0] dffe4a;
reg [0:0] dffe5a;
reg [0:0] dffe6a;
wire ena;
wire prn;
wire sclr;
initial
    dffe4a = 0; 
always @ (posedge clock or negedge prn or negedge clrn)
    if (prn == 1'b0) dffe4a <= {1{1'b1}}; 
    else if (clrn == 1'b0) dffe4a <= 1'b0; 
    else if (ena == 1'b1) dffe4a <= (d & (~sclr)); 
initial
    dffe5a = 0; 
always @ (posedge clock or negedge prn or negedge clrn)
    if (prn == 1'b0) dffe5a <= {1{1'b1}};
    else if (clrn == 1'b0) dffe5a <= 1'b0;
    else if (ena == 1'b1) dffe5a <= (dffe4a & (~sclr));
initial
    dffe6a = 0; 
always @ (posedge clock or negedge prn or negedge clrn)
    if (prn == 1'b0) dffe6a <= {1{1'b1}};
    else if (clrn == 1'b0) dffe6a <= 1'b0;
    else if (ena == 1'b1) dffe6a <= (dffe5a & (~sclr));
assign
    ena = 1'b1,  
    prn = 1'b1,  
    q = dffe6a,  
    sclr = 1'b0; 
endmodule
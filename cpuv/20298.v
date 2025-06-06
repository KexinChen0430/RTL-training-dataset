module bm_match1_str_arch(clock,
    reset_n,
    a_in,
    b_in,
    c_in,
    d_in,
    e_in,
    f_in,
    out0,
    out1,
    out2,
    out3,
    out4,
    out5
);
input	clock; 
input 	reset_n; 
input [`BITS0-1:0] a_in; 
input [`BITS0-1:0] b_in; 
input [`BITS1-1:0] c_in; 
input [`BITS1-1:0] d_in; 
input [`BITS2-1:0] e_in; 
input [`BITS3-1:0] f_in; 
output [`BITS2-1:0] out0; 
output [`BITS2-1:0] out1; 
output [`BITS3-1:0] out2; 
output [`BITS2-1:0] out3; 
output [`BITS2-1:0] out4; 
output [`BITS3-1:0] out5; 
reg [`BITS2-1:0] out0; 
reg [`BITS2-1:0] out1; 
reg [`BITS3-1:0] out2; 
wire [`BITS2-1:0] out3; 
wire [`BITS2-1:0] out4; 
wire [`BITS3-1:0] out5; 
assign out3 = a_in * b_in; 
assign out4 = c_in * d_in; 
assign out5 = e_in * f_in; 
always @(posedge clock) 
begin
    out0 <= a_in * b_in; 
    out1 <= c_in * d_in; 
    out2 <= e_in * f_in; 
end
endmodule 
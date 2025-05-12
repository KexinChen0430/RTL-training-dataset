module tb_arrmul(); 
wire [0:127] res; 
reg [0:127] r_A; 
reg [0:127] r_B; 
reg [0:1] c_ww; 
reg [0:4] a_op; 
reg [0:127] e_r; 
arrmul am (
    .A(r_A),   
    .B(r_B),   
    .ww(c_ww), 
    .op(a_op), 
    .result(res) 
);
initial begin
    $display($time, " << Starting the simulation >>");
    r_A = 128'h0402030405060708f00a0b0cff0eff00;
    r_B = 128'h03010202030303031004f505ff09fe10;
    e_r = 128'h000c0006000f00150f000a87fe01fd02;
    c_ww = `w8; 
    a_op = `aluwmuleu; 
    #10; 
    #30;
    $display($time, " << Finishing the simulation >>");
    $finish; 
end
endmodule
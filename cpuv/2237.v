module system_vga_hessian_0_0(
    clk_x16,      
    active,       
    rst,          
    x_addr,       
    y_addr,       
    g_in,         
    hessian_out   
);
;
input clk_x16;          
input active;           
input rst;              
input [9:0] x_addr;     
input [9:0] y_addr;     
input [7:0] g_in;       
output [31:0] hessian_out; 
endmodule
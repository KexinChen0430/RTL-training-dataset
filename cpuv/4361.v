module system_vga_nmsuppression_1_0(
    clk,            
    enable,         
    active,         
    x_addr_in,      
    y_addr_in,      
    hessian_in,     
    x_addr_out,     
    y_addr_out,     
    hessian_out     
);
input clk;              
input enable;           
input active;           
input [9:0] x_addr_in;  
input [9:0] y_addr_in;  
input [31:0] hessian_in; 
output [9:0] x_addr_out;  
output [9:0] y_addr_out;  
output [31:0] hessian_out; 
endmodule 
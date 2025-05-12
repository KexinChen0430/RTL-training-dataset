module _acl_mem2x_shiftreg(
    D,          
    clock,      
    resetn,     
    enable,     
    Q           
);
    parameter WIDTH = 32; 
    parameter DEPTH = 1;  
    input [WIDTH-1:0] D;          
    input clock, resetn, enable;  
    output [WIDTH-1:0] Q;         
    reg [DEPTH-1:0][WIDTH-1:0] local_ffs ;
    always @(posedge clock or negedge resetn)
        if (!resetn) 
            local_ffs <= '0; 
        else if (enable) 
            local_ffs <= {local_ffs[DEPTH-2:0], D}; 
    assign Q = local_ffs[DEPTH-1]; 
endmodule
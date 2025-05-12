module RouteCompute(
    input       `control_w  control_in,  
    input       `addrx_w    addrx,       
    input       `addry_w    addry,       
    input       `addrx_w    addrx_max,   
    input       `addry_w    addry_max,   
    output      `rmatrix_w  rmatrix);    
    wire                valid;          
    wire    `addrx_w    destx;          
    wire    `addry_w    desty;          
    /*******************
    assign valid = control_in[`valid_f]; 
    assign destx = control_in[`destx_f]; 
    assign desty = control_in[`desty_f]; 
    /***************
    assign rmatrix =
        valid ?  
        {destx < addrx, destx > addrx, desty > addry, desty < addry} : 
        5'b0000; 
endmodule
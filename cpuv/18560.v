module RouteCompute(
    input       `control_w  control_in, 
    input       `addrx_w    addrx, 
    input       `addry_w    addry, 
    input       `addrx_w    addrx_max, 
    input       `addry_w    addry_max, 
    input                   clk, 
    input                   rst, 
    output                  resource_go, 
    output      `rmatrix_w  rmatrix); 
    wire                valid; 
    wire    `addrx_w    destx; 
    wire    `addry_w    desty; 
    assign valid = control_in[`valid_f]; 
    assign destx = control_in[`destx_f]; 
    assign desty = control_in[`desty_f]; 
    assign resource_go = ((addrx == destx) && (addry == desty)) ? 1'b1 : 1'b0; 
    reg     `addrx_w    resultx; 
    reg     `addry_w    resulty; 
    assign rmatrix = {resultx, resulty}; 
    always @(*) begin
            if ((destx == addrx)  && (desty == addry)) begin
                resultx = 2'b00; 
                resulty = 2'b00; 
            end else begin
                if (destx > addrx) begin
                    resultx = 2'b01;        
                end else if (destx < addrx) begin
                    resultx = 2'b10;        
                end else begin
                    resultx = 2'b00; 
                end
                if (desty > addry) begin
                    resulty = 2'b10;        
                end else if (desty < addry) begin
                    resulty = 2'b01;        
                end else begin
                    resulty = 2'b00; 
                end
            end
    end
endmodule
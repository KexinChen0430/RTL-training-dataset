module fj_dff_ec_muxscan(
    q,    
    d,    
    si,   
    sm,   
    clk,  
    c     
);
output q;      
input  d, si;  
input  sm;     
input  clk;    
input  c;      
reg q;         
always @(posedge clk or posedge c) begin
    if (c) begin
        q <= #1 1'b0;
    end
    else if (sm == 1'b0) begin
        q <= #1 d;
    end
    else if (sm == 1'b1) begin
        q <= #1 si;
    end
    else begin
        q <= #1 1'bx;
    end
end
endmodule 
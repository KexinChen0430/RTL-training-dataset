module WHIRLPOOL_WCIPHER_SBOX ( 
        output reg [7:0 ] odata, 
        input      [7:0 ] idata  
);
reg  [3:0] a, b, d; 
wire [3:0] c, g, h; 
always @* 
begin
    case (idata[3:0]) 
    endcase
end
always @* 
begin
    case (idata[7:4]) 
    endcase
end
always @* 
begin
    case (c[3:0]) 
    endcase
end
assign c[3:0] = { a[3]^b[3] , a[2]^b[2] , a[1]^b[1] , a[0]^b[0] }; 
assign g[3:0] = { a[3]^d[3] , a[2]^d[2] , a[1]^d[1] , a[0]^d[0] }; 
assign h[3:0] = { d[3]^b[3] , d[2]^b[2] , d[1]^b[1] , d[0]^b[0] }; 
always @* 
begin
    case (g[3:0]) 
    endcase
end
always @* 
begin
    case (h[3:0]) 
    endcase
end
endmodule 
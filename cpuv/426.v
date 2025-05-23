module sram1024x18 (
    clk_a,     
    cen_a,     
    wen_a,     
    addr_a,    
    wmsk_a,    
    wdata_a,   
    rdata_a,   
    clk_b,     
    cen_b,     
    wen_b,     
    addr_b,    
    wmsk_b,    
    wdata_b,   
    rdata_b    
);
    (* clkbuf_sink *) input wire clk_a;
    (* clkbuf_sink *) input wire clk_b;
    input wire cen_a;
    input wire wen_a;
    input wire [9:0] addr_a;
    input wire [17:0] wmsk_a;
    input wire [17:0] wdata_a;
    output reg [17:0] rdata_a; 
    input wire cen_b;
    input wire wen_b;
    input wire [9:0] addr_b;
    input wire [17:0] wmsk_b;
    input wire [17:0] wdata_b;
    output reg [17:0] rdata_b; 
    reg [17:0] ram [1023:0]; 
    reg [9:0] laddr_a;   
    reg lcen_a;          
    reg lwen_a;          
    reg [17:0] lwdata_a; 
    reg [17:0] lwmsk_a;  
    reg [9:0] laddr_b;   
    reg lcen_b;          
    reg lwen_b;          
    reg [17:0] lwdata_b; 
    reg [17:0] lwmsk_b;  
    always @(posedge clk_a) begin
        laddr_a <= addr_a;
        lwdata_a <= wdata_a;
        lwmsk_a <= wmsk_a;
        lcen_a <= cen_a;
        lwen_a <= wen_a;
    end
    always @(posedge clk_b) begin
        laddr_b <= addr_b;
        lwdata_b <= wdata_b;
        lwmsk_b <= wmsk_b;
        lcen_b <= cen_b;
        lwen_b <= wen_b;
    end
    always @(*) begin
        if ((lwen_b == 0) && (lcen_b == 0)) begin
            ram[laddr_b][0] = (lwmsk_b[0] ? ram[laddr_b][0] : lwdata_b[0]);
            ram[laddr_b][17] = (lwmsk_b[17] ? ram[laddr_b][17] : lwdata_b[17]);
            lwen_b = 1; 
        end
        if (lcen_b == 0) begin
            rdata_b = ram[laddr_b]; 
            lcen_b = 1; 
        end
        else
            rdata_b = rdata_b; 
    end
    always @(*) begin
        if ((lwen_a == 0) && (lcen_a == 0)) begin
            ram[laddr_a][17] = (lwmsk_a[17] ? ram[laddr_a][17] : lwdata_a[17]);
            lwen_a = 1; 
        end
        if (lcen_a == 0) begin
            rdata_a = ram[laddr_a]; 
            lcen_a = 1; 
        end
        else
            rdata_a = rdata_a; 
    end
endmodule
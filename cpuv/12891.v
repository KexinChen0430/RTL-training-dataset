module regfile( 
    input             clk, 
    input             wen, 
    input      [4 :0] raddr1, 
    input      [4 :0] raddr2, 
    input      [4 :0] waddr, 
    input      [31:0] wdata, 
    output reg [31:0] rdata1, 
    output reg [31:0] rdata2, 
    input      [4 :0] test_addr, 
    output reg [31:0] test_data, 
    input             resetn 
    );
    reg [31:0] rf[31:0]; 
    always @(posedge clk) 
    begin
        if (wen) 
        begin
            rf[waddr] <= wdata; 
        end
        if(!resetn) begin 
            rf[0] <= 0;
            rf[31] <= 0;
        end
    end
    always @(*) 
    begin
        case (raddr1) 
            5'd1 : rdata1 <= rf[1 ];
            5'd31: rdata1 <= rf[31];
            default : rdata1 <= 32'd0; 
        endcase
    end
    always @(*) 
    begin
        case (raddr2) 
            5'd1 : rdata2 <= rf[1 ];
            5'd31: rdata2 <= rf[31];
            default : rdata2 <= 32'd0; 
        endcase
    end
    always @(*) 
    begin
        case (test_addr) 
            5'd1 : test_data <= rf[1 ];
            5'd31: test_data <= rf[31];
            default : test_data <= 32'd0; 
        endcase
    end
endmodule
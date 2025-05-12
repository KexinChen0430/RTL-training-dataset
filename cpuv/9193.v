module colour_gen(input clk, input[9:0] x, input[9:0] y, input[0:13] d, output reg[4:0] addr_row,
                  output reg[9:0] r, output reg[9:0] g, output reg[9:0] b, input rst);
reg[0:13] row_buf;
reg[4:0] ycount;
always @(posedge clk)
    row_buf <= d;
always @(posedge clk)
begin
    if(x == 640 && y < 480)
        ycount <= ycount+5'd1;
    if(ycount == 24) begin
        ycount <= 0;
        addr_row <= addr_row+5'd1;
    end
    if(addr_row == 19 && ycount == 24)
        addr_row <= 0;
    if(rst) begin
        addr_row <= 0;
        ycount <= 0;
    end
end
always @(posedge clk)
begin
    if(x > 639 || y > 479) begin
        r <= 0;
        g <= 0;
        b <= 0;
    end
    else if(x < 152 || x >= 488) begin
        r <= {8'd136,2'b0};
        g <= {8'd138,2'b0};
        b <= {8'd133,2'b0};
    end
    else if(x < 176) begin
        if(row_buf[0]) begin
            r <= {8'd115,2'b0}; g <= {8'd210,2'b0}; b <= {8'd22,2'b0};
        end
        else begin
            r <= {8'd85,2'b0}; g <= {8'd87,2'b0}; b <= {8'd83,2'b0};
        end
    end
end
endmodule
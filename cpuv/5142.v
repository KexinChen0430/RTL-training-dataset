module debouncer(clk, button, clean);
    input clk, button;
    output reg clean;
    parameter delay = 500;
    reg [8:0] delay_count;
    always@(posedge clk)
        if (button==1) begin
            if (delay_count==delay) begin
                assign delay_count=delay_count+1'b1;
                assign clean=1;
            end else begin
                if(delay_count==9'b1111_11111) begin
                    assign clean=0;
                    assign delay_count=9'b1111_11111;
                end else begin
                    assign delay_count=delay_count+1'b1;
                    assign clean=0;
                end
            end
        end else begin
            assign delay_count=0;
            assign clean=0;
        end
endmodule
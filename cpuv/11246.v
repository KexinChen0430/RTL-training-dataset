module digital_pll_controller(reset, clock, osc, div, trim); 
    input reset; 
    input clock; 
    input osc; 
    input [4:0] div; 
    output [25:0] trim; 
    wire [25:0] trim; 
    reg [2:0] oscbuf; 
    reg [2:0] prep; 
    reg [4:0] count0; 
    reg [4:0] count1; 
    reg [6:0] tval; 
    wire [4:0] tint; 
    wire [5:0] sum; 
    assign sum = count0 + count1; 
    assign tint = tval[6:2]; 
    assign trim = (tint == 5'd0)  ? 26'b0000000000000_0000000000000 :
                  (tint == 5'd25) ? 26'b1111101111111_1111111111111 :
                                    26'b1111111111111_1111111111111;
    always @(posedge clock or posedge reset) begin
        if (reset == 1'b1) begin 
            tval <= 7'd0; 
            oscbuf <= 3'd0; 
            prep <= 3'd0; 
            count0 <= 5'd0; 
            count1 <= 5'd0; 
        end else begin 
            oscbuf <= {oscbuf[1:0], osc}; 
            if (oscbuf[2] != oscbuf[1]) begin 
                count1 <= count0; 
                count0 <= 5'b00001; 
                prep <= {prep[1:0], 1'b1}; 
                if (prep == 3'b111) begin 
                    if (sum > div) begin 
                        tval <= tval + 1; 
                    end else if (sum < div) begin 
                        tval <= tval - 1; 
                    end
                end
            end else begin 
                if (count0 != 5'b11111) begin 
                    count0 <= count0 + 1; 
                end
            end
        end
    end
endmodule
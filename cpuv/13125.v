module counter_4bit_2step(input clk, reset, output reg[3:0] out, output reg carry_out);
    reg [3:0] curr; 
    reg should_add = 0, co = 0; 
    always @(posedge clk, negedge reset) begin
        if (~reset) begin
            curr = 0; 
            co = 0; 
            should_add = 0; 
        end else begin
            if (should_add) begin
                curr = curr + 1'b1; 
                if (curr == 4'b0000)
                    co = 1'b1; 
                else co = 1'b0; 
            end
            should_add = ~should_add;
        end
        out = curr;
        carry_out = co;
    end
endmodule
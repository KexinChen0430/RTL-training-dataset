module next_block(input clk, input next, input[2:0] rand, output reg[2:0] type, input rst);
reg[2:0] count;
always @(posedge clk)
begin
    if(next) begin
        if(rand > 6) begin 
           type <= count;
           count <= count + 3'd1;
        end
        else
            type <= rand;
    end
    if(count == 6)
        count <= 0;
    if(rst) begin
        count <= 0;
        if(rand > 6)
            type <= 0;
        else
            type <= rand;
    end
end
endmodule
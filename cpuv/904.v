module sub_cast_bug374(
    input clk,        
    input [4:0] cyc5  
);
    integer i;
    always @(posedge clk) begin
        i <= integer'(cyc5);
    end
endmodule
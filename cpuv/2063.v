module program_counter(
    input clk, 
    input [31:0]pc_next, 
    output reg [31:0]pc_now 
);
     initial begin
        pc_now <= 0; 
     end
    always @(posedge clk) begin 
        pc_now <= pc_next; 
    end
endmodule
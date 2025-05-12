module jt51_timer #(
    parameter counter_width = 10, 
    mult_width = 5                
)
(
    input clk,                    
    input rst,                    
    input [counter_width-1:0] start_value, 
    input load,                   
    input clr_flag,               
    input set_run,                
    input clr_run,                
    output reg flag,              
    output reg overflow           
);
reg run;
reg [mult_width-1:0] mult;
reg [counter_width-1:0] cnt;
always @(posedge clk) begin
    if (clr_flag || rst) begin
        flag <= 1'b0; 
    end else if (overflow) begin
        flag <= 1'b1; 
    end
end
always @(posedge clk) begin
    if (clr_run || rst) begin
        run <= 1'b0; 
    end else if (set_run || load) begin
        run <= 1'b1; 
    end
end
reg [mult_width+counter_width-1:0] next, init;
always @(*) begin
    {overflow, next} = {1'b0, cnt, mult} + 1'b1; 
    init = {start_value, {(mult_width){1'b0}}};  
end
always @(posedge clk) begin : counter
    if (load) begin
        mult <= {(mult_width){1'b0}}; 
        cnt <= start_value;           
    end else if (run) begin
        {cnt, mult} <= overflow ? init : next; 
    end
end
endmodule
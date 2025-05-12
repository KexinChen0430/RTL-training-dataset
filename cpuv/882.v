module bsg_counter_dynamic_limit_en #(
    parameter `BSG_INV_PARAM(width_p) 
)
(
    input                      clk_i,       
    input                      reset_i,     
    input                      en_i,        
    input        [width_p-1:0] limit_i,     
    output logic [width_p-1:0] counter_o,   
    output                     overflowed_o 
);
wire [width_p-1:0] counter_plus_1 = counter_o + width_p'(1);
assign overflowed_o = (counter_plus_1 == limit_i);
always_ff @ (posedge clk_i) begin
    if (reset_i) begin
        counter_o <= 0;
    end else if (en_i) begin
        if (overflowed_o) begin
            counter_o <= 0;
        end else begin
            counter_o <= counter_plus_1;
        end
    end
end
endmodule 
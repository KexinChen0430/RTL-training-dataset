module edge_detector(
    clk,          
    reset_n,      
    in,           
    out,          
    edge_detect   
);
    `include "parameters_global.v"
    input clk;
    input reset_n;
    input in;
    input edge_detect;
    output reg out; 
    reg latch;
    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            out     <= #`DEL 1'b0;
            latch   <= #`DEL 1'b0;
        end
        else begin
            latch   <= #`DEL in;
            if (edge_detect == edge_rising) begin
                if (latch == 0 && in == 1)
                    out     <= #`DEL 1'b1; 
                else
                    out     <= #`DEL 1'b0; 
            end
            else begin
                if (latch == 1 && in == 0)
                    out     <= #`DEL 1'b1; 
                else
                    out     <= #`DEL 1'b0; 
            end
        end
    end
endmodule
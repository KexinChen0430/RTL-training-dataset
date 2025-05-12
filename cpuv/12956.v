module uart_symclk (
    input clk,                  
    input n_reset,              
    input [23:0] clks_per_sym,  
    output reg setup,           
    output reg sample,          
    output reg symend,          
); 
    localparam CLKS_PER_SYM_MIN = 4; 
    reg [23:0] count;                
    wire [23:0] clks_per_sym_limited;
    wire [23:0] clks_per_sym_half;
    assign clks_per_sym_limited = (clks_per_sym >= CLKS_PER_SYM_MIN) ? clks_per_sym : CLKS_PER_SYM_MIN;
    assign clks_per_sym_half = clks_per_sym_limited >> 1; 
    initial begin
        count <= 0;
        setup <= 0;
        sample <= 0;
        symend <= 0;
    end
    always @(posedge clk) begin
        if (n_reset) begin 
            if (count == 0) begin 
                count <= count + 1;
                setup <= 1; 
                sample <= 0;
                symend <= 0;
            end else if (count == clks_per_sym_half - 1) begin 
                count <= count + 1;
                setup <= 0;
                sample <= 1; 
                symend <= 0;
            end else if (count >= clks_per_sym_limited - 1) begin 
                count <= 0; 
                setup <= 0;
                sample <= 0;
                symend <= 1; 
            end else begin 
                count <= count + 1;
                setup <= 0;
                sample <= 0;
                symend <= 0;
            end
        end else begin 
            count <= 0; 
            setup <= 0;
            sample <= 0;
            symend <= 0;
        end
    end
endmodule 
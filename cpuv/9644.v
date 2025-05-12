module stratixv_hssi_aux_clock_div (
    clk,     
    reset,   
    enable_d, 
    d,        
    clkout   
);
input clk,reset;
input enable_d;
input [7:0] d; 
output clkout;
parameter clk_divide_by  = 1; 
parameter extra_latency  = 0; 
integer clk_edges,m; 
reg [2*extra_latency:0] div_n_register; 
reg [7:0] d_factor_dly; 
reg [31:0] clk_divide_value; 
wire [7:0] d_factor; 
wire int_reset; 
initial
begin
    div_n_register = 'b0; 
    clk_edges = -1; 
    m = 0; 
    d_factor_dly =  'b0; 
    clk_divide_value = clk_divide_by; 
end
assign d_factor = (enable_d === 1'b1) ? d : clk_divide_value[7:0]; 
always @(d_factor)
begin
    d_factor_dly <= d_factor; 
end
assign int_reset = (d_factor !== d_factor_dly) ? 1'b1 : 1'b0; 
always @(posedge clk or negedge clk or posedge reset or posedge int_reset)
begin
    div_n_register <= {div_n_register, div_n_register[0]}; 
    if ((reset === 1'b1) || (int_reset === 1'b1)) 
    begin
        clk_edges = -1; 
        div_n_register <= 'b0; 
    end
    else
    begin
        if (clk_edges == -1) 
        begin
            div_n_register[0] <= clk; 
            if (clk == 1'b1) clk_edges = 0; 
        end
        else if (clk_edges % d_factor == 0) 
                div_n_register[0] <= ~div_n_register[0]; 
        if (clk_edges >= 0 || clk == 1'b1) 
            clk_edges = (clk_edges + 1) % (2*d_factor) ; 
    end
end
assign clkout = div_n_register[2*extra_latency]; 
endmodule
module bw_clk_gclk_inv_r90_256x (
    clkout, 
    clkin   
);
    output clkout; 
    input  clkin;  
    assign clkout = ~( clkin );
endmodule 
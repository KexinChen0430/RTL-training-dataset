module lcd(clk, lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e, sf_ce0); 
    parameter k = 15; 
    input clk; 
    output lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e, sf_ce0; 
    reg lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e, sf_ce0; 
    reg [k+8-1:0] count; 
    reg lcd_busy; 
    reg [5:0] lcd_char; 
    reg lcd_stb; 
    reg [6:0] lcd_intf_signals; 
    always @ (posedge clk) 
        begin
            count <= count + 1; 
            lcd_busy <= 1'b1; 
            sf_ce0 <= 1; 
            case (count[k+7:k+2]) 
                default: lcd_char <= 6'h10; 
            endcase
            lcd_stb <= ^count[k+1:k+0] & ~lcd_rw & lcd_busy; 
            lcd_intf_signals <= {lcd_stb, lcd_char}; 
            {lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e} <= lcd_intf_signals; 
        end
endmodule 
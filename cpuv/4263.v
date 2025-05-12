module key_logic_fsm (
    clock,reset,k[3:0],lcd_busy,reg_busy,
    run_timer,reset_timer,insert_value,clear_value);
input clock; 
input reset; 
input [3:0] k; 
input lcd_busy; 
input reg_busy; 
output run_timer; 
output reset_timer; 
output insert_value; 
output clear_value; 
reg run_timer; 
reg reset_timer; 
reg insert_value; 
reg clear_value; 
reg [10:0] fstate; 
reg [10:0] reg_fstate; 
parameter s_pre_start=0,s_run=1,s_pre_pause=2,s_pause=3,s_idle=4,s_pre_reset=5,s_reset=6,s_retrieve=7,s_save=8,s_pre_clear=9,s_clear=10;
always @(posedge clock)
begin
    if (clock) begin
        fstate <= reg_fstate;
    end
end
always @(fstate or reset or k or lcd_busy or reg_busy)
begin
    if (reset) begin
        reg_fstate <= s_idle;
        run_timer <= 1'b0;
        reset_timer <= 1'b0;
        insert_value <= 1'b0;
        clear_value <= 1'b0;
    end
    else begin
        case (fstate)
        endcase
    end
end
endmodule
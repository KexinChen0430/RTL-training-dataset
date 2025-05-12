module red_pitaya_compressor_block
#(
    parameter     SHIFTBITS =     4, 
    parameter     SIGNALBITS   = 14, 
    parameter     MINBW        = 10  
)
(
    input clk_i,                       
    input rstn_i,                      
    input [SHIFTBITS:0] shift,         
    input filter_on,                   
    input highpass,                    
    input signed  [SIGNALBITS-1:0] signal_i, 
    input signed  [SIGNALBITS-1:0] setpoint_i, 
    output signed [SIGNALBITS-1:0] signal_o   
);
reg  signed [SIGNALBITS+SHIFTBITS-1:0]    y; 
reg  signed [SIGNALBITS+SHIFTBITS-1:0]    delta; 
wire signed [SIGNALBITS+SHIFTBITS-1:0]    shifted_delta; 
wire signed [SIGNALBITS-1:0]  y_out; 
wire filter_off; 
assign y_out = y[SHIFTBITS+SIGNALBITS-1:SHIFTBITS]; 
assign shifted_delta = delta << shift; 
always @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin 
        y <=            {SHIFTBITS+SIGNALBITS{1'b0}}; 
        delta <=        {SHIFTBITS+SIGNALBITS{1'b0}}; 
    end
    else begin 
        delta <= signal_i - y_out; 
        y <= y + shifted_delta; 
    end
end
assign signal_o = (filter_on == 1'b0) ? signal_i : 
                  ( (highpass==1'b0) ? y_out : delta); 
endmodule 
module NormaliseSum(
    input [1:0] idle_AddState,            
    input [31:0] sout_AddState,           
    input [1:0] modeout_AddState,         
    input operationout_AddState,          
    input NatLogFlagout_AddState,         
    input [27:0] sum_AddState,            
    input [7:0] InsTag_AddState,          
    input clock,                          
    output reg [1:0] idle_NormaliseSum,           
    output reg [31:0] sout_NormaliseSum,          
    output reg [1:0] modeout_NormaliseSum,        
    output reg operationout_NormaliseSum,         
    output reg NatLogFlagout_NormaliseSum,        
    output reg [27:0] sum_NormaliseSum,           
    output reg [7:0] InsTag_NormaliseSum          
);
parameter mode_circular  = 2'b01,
          mode_linear    = 2'b00,
          mode_hyperbolic= 2'b11;
parameter no_idle = 2'b00,
          allign_idle = 2'b01,
          put_idle = 2'b10;
wire [7:0] s_exponent;
assign s_exponent = sout_AddState[30:23]; 
always @ (posedge clock)
begin
    InsTag_NormaliseSum <= InsTag_AddState;
    idle_NormaliseSum <= idle_AddState;
    modeout_NormaliseSum <= modeout_AddState;
    operationout_NormaliseSum <= operationout_AddState;
    NatLogFlagout_NormaliseSum <= NatLogFlagout_AddState;
    if (idle_AddState != put_idle) begin
        sout_NormaliseSum[31] <= sout_AddState[31]; 
        sout_NormaliseSum[22:0] <= sout_AddState[22:0]; 
        if (sum_AddState[27] == 1'b1) begin
            sout_NormaliseSum[30:23] <= s_exponent + 1;
            sum_NormaliseSum <= sum_AddState >> 1;
        end
        else if(sum_AddState[26:3] == 24'h000000) begin
            sout_NormaliseSum[30:23] <= 10'h382; 
        end
        else if (sum_AddState[26:4] == 23'h000000) begin
            sout_NormaliseSum[30:23] <= s_exponent - 23;
            sum_NormaliseSum <= sum_AddState << 23;
        end
        else if (sum_AddState[26] == 1'h0) begin
            sout_NormaliseSum[30:23] <= s_exponent - 1;
            sum_NormaliseSum <= sum_AddState << 1;
        end
        else begin
            sout_NormaliseSum[30:23] <= s_exponent;
            sum_NormaliseSum <= sum_AddState;
        end
    end
    else begin
        sout_NormaliseSum <= sout_AddState;
        sum_NormaliseSum <= 0;
    end
end
endmodule
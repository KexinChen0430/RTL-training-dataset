module BiquadCascade #(
    parameter WIDTH_D = 18, 
    parameter WIDTH_C = 18, 
    parameter COEFF_B0 = 0, 
    parameter COEFF_B1 = 0, 
    parameter COEFF_B2 = 0, 
    parameter COEFF_A1 = 0, 
    parameter COEFF_A2 = 0, 
    parameter SCALING  = 0  
)
(
    input  clk,                         
    input  rst,                         
    input  inStrobe,                    
    input  signed [WIDTH_D-1:0] dataIn, 
    output reg outStrobe,               
    output signed [WIDTH_D-1:0] dataOut 
);
localparam ST_IDLE = 0;
localparam ST_X_B0 = 1;
localparam ST_X_B1 = 2;
localparam ST_X_B2 = 3;
localparam ST_Y_A1 = 4;
localparam ST_Y_A2 = 5;
reg signed [WIDTH_D-1:0] multInA;
reg signed [WIDTH_C-1:0] multInB;
reg signed [WIDTH_D+WIDTH_C-1:0] multOut;
reg signed [WIDTH_D+WIDTH_C+2:0] adderOut; 
reg signed [WIDTH_D-1:0] y;
reg signed [WIDTH_D-1:0] yD1;
reg signed [WIDTH_D-1:0] x;
reg signed [WIDTH_D-1:0] xD1;
reg signed [WIDTH_D-1:0] xD2;
reg [2:0] state;
reg [2:0] stateD1;
reg [2:0] stateD2;
reg storeY;
initial begin
    y       = 'd0;
    yD1     = 'd0;
    x       = 'd0;
    xD1     = 'd0;
    xD2     = 'd0;
    multInA = 'd0;
    multInB = 'd0;
    multOut = 'd0;
    adderOut = 'd0;
    state   = ST_IDLE;
    stateD1 = ST_IDLE;
    stateD2 = ST_IDLE;
    storeY  = 1'b0;
    outStrobe = 1'b0;
end
assign dataOut = y;
always @(posedge clk) begin
    if (rst) begin
        y         <= 'd0;
        yD1       <= 'd0;
        x         <= 'd0;
        xD1       <= 'd0;
        xD2       <= 'd0;
        multInA   <= 'd0;
        multInB   <= 'd0;
        multOut   <= 'd0;
        adderOut  <= 'd0;
        outStrobe <= 1'b0;
    end
    else begin
        if (inStrobe) begin
            x   <= dataIn;
            xD1 <= x;
            xD2 <= xD1;
        end
        if (storeY) begin
            y <= adderOut[SCALING+:WIDTH_D];
            yD1 <= y;
        end
        outStrobe <= storeY;
        case (state)
            ST_IDLE : begin
                multInA <= x;
                multInB <= COEFF_B0;
            end
            ST_X_B0 : begin
                multInA <= x;
                multInB <= COEFF_B0;
            end
            ST_X_B1 : begin
                multInA <= xD1;
                multInB <= COEFF_B1;
            end
            ST_X_B2 : begin
                multInA <= xD2;
                multInB <= COEFF_B2;
            end
            ST_Y_A1 : begin
                multInA <= y;
                multInB <= COEFF_A1;
            end
            ST_Y_A2 : begin
                multInA <= yD1;
                multInB <= COEFF_A2;
            end
        endcase
        case (stateD2)
            ST_IDLE : begin
                adderOut <= multOut;
            end
            ST_X_B0 : begin
                adderOut <= multOut;
            end
            ST_X_B1 : begin
                adderOut <= multOut + adderOut;
            end
            ST_X_B2 : begin
                adderOut <= multOut + adderOut;
            end
            ST_Y_A1 : begin
                adderOut <= multOut + adderOut;
            end
            ST_Y_A2 : begin
                adderOut <= multOut + adderOut;
            end
        endcase
        multOut <= multInA * multInB;
    end
end
always @(posedge clk) begin
    if (rst) begin
        state   <= ST_IDLE;
        stateD1 <= ST_IDLE;
        stateD2 <= ST_IDLE;
    end
    else begin
        stateD1 <= state;
        stateD2 <= stateD1;
        storeY  <= (stateD2 == ST_Y_A2);
        case (state)
            ST_IDLE : state <= (inStrobe) ? ST_X_B0 : ST_IDLE;
            ST_X_B0 : state <= ST_X_B1;
            ST_X_B1 : state <= ST_X_B2;
            ST_X_B2 : state <= ST_Y_A1;
            ST_Y_A1 : state <= ST_Y_A2;
            ST_Y_A2 : state <= (inStrobe) ? ST_X_B0 : ST_IDLE;
            default : state <= ST_IDLE;
        endcase
    end
end
endmodule
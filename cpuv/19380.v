module timer32(clk, reset, din, dout, wren, rden, addr);
input clk, reset, wren, rden; 
input [31:0] din;             
output [31:0] dout;           
input [1:0] addr;             
reg [31:0] out, out2, timer, period;
reg [2:0] control;
`define TIMER_REG    2'b00
`define PERIOD_REG   2'b01
`define CONTROL_REG  2'b10
`define DUMMY_REG    2'b11
`define ZERO         32'h00000000
`define COUNT        control[0]
`define TMR          control[1]
`define TOGGLE       control[2]
parameter PERIOD = 32'h0000000F;  
parameter ENBIT = 1'b0;           
always @(posedge clk or posedge reset) begin
    if(reset) begin
        timer <= `ZERO;
        period <= PERIOD;
        `COUNT = ENBIT;
        `TMR = 0;
        `TOGGLE = 0;
    end
    else begin
        if(`COUNT) begin
            timer <= timer + 1;
        end
        if(rden & (addr == `CONTROL_REG) & `TMR)
            `TMR = ~`TMR;
        if(timer == period) begin
            `TMR = 1;
            `TOGGLE = ~`TOGGLE;
            timer <= `ZERO;
        end
        if(wren & (addr == `PERIOD_REG))
            period <= din;
        if(wren & (addr == `CONTROL_REG)) begin
            `TMR = ~`TMR;
            `COUNT = din[0];
            `TMR = din[1];
            `TOGGLE = din[2];
        end
    end
end
always @* begin
    out = `ZERO;
    case(addr)
        `TIMER_REG:
            out = timer;        
        `PERIOD_REG:
            out = period;       
        `CONTROL_REG:
            out[2:0] = control; 
    endcase
end
always @* begin
    out2 = `ZERO;
    case(rden)
        1'b1:
            out2 = out; 
    endcase
end
assign dout = out2;
endmodule
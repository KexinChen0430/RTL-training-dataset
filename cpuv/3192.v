module SRL16_MOD #( 
    parameter INIT = 16'h0000, 
    parameter INVERT = 0 
) (
    output Q, 
    input  A0, 
    input  A1, 
    input  A2, 
    input  A3, 
    input  CLK, 
    input  D); 
    reg  [15:0] data; 
    wire        clk_; 
    wire  [3:0] a = {A3, A2, A1, A0}; 
    assign Q = (|data) ? ((&data) ? 1'b1 : data[a]) :  1'b0 ;
    assign clk_ = INVERT? (~CLK) : CLK;
    initial
    begin
          assign  data = INIT; 
          while (clk_ === 1'b1 || clk_ === 1'bX) 
            #10; 
          deassign data; 
    end
    always @(posedge clk_)
    begin
    {data[15:0]} <= #100 {data[14:0], D}; 
    end
endmodule
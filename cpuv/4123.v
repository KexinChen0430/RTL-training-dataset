module SigmaDeltaFast #( 
    parameter WIDTH = 4, 
    parameter OUTLEN = (1 << WIDTH) 
)
(
    input clk, 
    input rst, 
    input en, 
    input signed [WIDTH-1:0] in, 
    output reg [OUTLEN-1:0] sdOut 
);
localparam DEPTH = 2**(2*WIDTH); 
reg signed [WIDTH-1:0] feedback; 
reg [WIDTH-1:0] fbLookup [DEPTH-1:0]; 
reg [OUTLEN-1:0] outLookup [DEPTH-1:0]; 
integer i; 
integer j; 
integer k; 
reg [WIDTH-1:0] tempFb; 
reg [WIDTH-1:0] tempIn; 
initial begin
    feedback = 'd0; 
    sdOut = 32'hAAAA_AAAA; 
    for (i=0; i<(2**WIDTH); i=i+1) begin
        for (j=0; j<(2**WIDTH); j=j+1) begin
            tempIn = i[WIDTH-1:0]; 
            tempFb = j[WIDTH-1:0]; 
            for (k=0; k<OUTLEN; k=k+1) begin
                {outLookup[{i[WIDTH-1:0],j[WIDTH-1:0]}][k], tempFb} = tempFb + {~tempIn[WIDTH-1], tempIn[WIDTH-2:0]};
            end
            fbLookup[{i[WIDTH-1:0],j[WIDTH-1:0]}] = tempFb;
        end
    end
end
always @(posedge clk) begin
    if (rst) begin 
        feedback <= 'd0; 
        sdOut <= 32'hAAAA_AAAA; 
    end
    else if (en) begin 
        sdOut <= outLookup[{in, feedback}]; 
        feedback <= fbLookup[{in,feedback}]; 
    end
end
endmodule
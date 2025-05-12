module COUNTER(
    input [7:0] DATA,    
    input NCCLR,         
    input NCCKEN,        
    input CCK,           
    input NCLOAD,        
    input RCK,           
    output [7:0] QDATA   
);
    parameter CLK_DIVIDER_WIDTH = 8;
    reg [CLK_DIVIDER_WIDTH-1:0] _icounter;
    assign QDATA = _icounter;
    initial begin
        _icounter = {(CLK_DIVIDER_WIDTH){1'b0}};
    end
    always @(posedge CCK, negedge NCCKEN, negedge NCCLR) begin
        if (~NCCKEN) begin
            if (~NCCLR) begin
                _icounter = 8'h0;
            end
            else if (~NCLOAD) begin
                _icounter = DATA;
            end
            else begin
                if (CCK == 1) begin
                    _icounter = _icounter + 1;
                end
            end
        end
    end
endmodule
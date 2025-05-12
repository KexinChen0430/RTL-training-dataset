module zwait(
    input  wire rst_n,                       
    input  wire wait_start_gluclock,         
    input  wire wait_start_comport,          
    input  wire wait_end,                    
    output reg  [6:0] waits,                 
    output wire wait_n,                      
    output wire spiint_n                     
);
`ifdef SIMULATE
    initial
    begin
        waits <= 7'd0;
    end
`endif
    wire wait_off_n;                         
    assign wait_off_n = (~wait_end) & rst_n; 
    always @(posedge wait_start_gluclock, negedge wait_off_n)
    if( !wait_off_n )
        waits[0] <= 1'b0;                    
    else if( wait_start_gluclock )
        waits[0] <= 1'b1;                    
    always @(posedge wait_start_comport, negedge wait_off_n)
    if( !wait_off_n )
        waits[1] <= 1'b0;                    
    else if( wait_start_comport )
        waits[1] <= 1'b1;                    
    always @(posedge wait_end)
    begin
        waits[6:2] <= 5'd0;                  
    end
`ifndef SIMULATE
    assign spiint_n = ~|waits;
    assign wait_n = spiint_n ? 1'bZ : 1'b0;
`else
    assign spiint_n = 1'b1;
    assign wait_n = 1'bZ;
`endif
endmodule
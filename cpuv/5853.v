module lpm_fifo_dc_dffpipe (d, clock, aclr, q); 
    parameter lpm_delay = 1; 
    parameter lpm_width = 64; 
    input [lpm_width-1:0] d; 
    input clock; 
    input aclr; 
    output [lpm_width-1:0] q; 
    reg [lpm_width-1:0] dffpipe [lpm_delay:0]; 
    reg [lpm_width-1:0] q; 
    integer delay; 
    integer i; 
    initial
    begin
        delay <= lpm_delay - 1; 
        for (i = 0; i <= lpm_delay; i = i + 1) 
            dffpipe[i] <= 0;
        q <= 0; 
    end
    always @(posedge aclr or posedge clock) 
    begin
        if (aclr) 
        begin
            for (i = 0; i <= lpm_delay; i = i + 1) 
                dffpipe[i] <= 0;
            q <= 0; 
        end
        else if (clock) 
        begin
            if ((lpm_delay > 0) && ($time > 0)) 
            begin
`ifdef VERILATOR 
                if (lpm_delay > 0) 
`else
                if (delay > 0) 
`endif
                begin
`ifdef VERILATOR 
                    for (i = lpm_delay-1; i > 0; i = i - 1) 
`else
                    for (i = delay; i > 0; i = i - 1) 
`endif
                        dffpipe[i] <= dffpipe[i - 1];
                    q <= dffpipe[delay - 1]; 
                end
                else
                    q <= d; 
                dffpipe[0] <= d; 
            end
        end
    end 
    always @(d) 
    begin
        if (lpm_delay == 0) 
            q <= d; 
    end 
endmodule 
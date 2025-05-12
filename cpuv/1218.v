module body
    input clk,        
    input ena,        
    input dstrb,      
    input [7:0] din_00, din_01, din_10, 
    output douten,    
    output [7:0] dout; 
    reg ld_zigzag;
    always @(posedge clk)
        if(ena)
            ld_zigzag <= #1 dstrb; 
    assign douten = ld_zigzag;
    reg [7:0] sresult[63:0];
    always @(posedge clk)
        if(ena)
            if(ld_zigzag)   
            begin
                sresult[63] <= #1 din_00;
                sresult[00] <= #1 din_77;
            end
            else       
                for (n=1; n<=63; n=n+1) 
                    sresult[n] <= #1 sresult[n -1]; 
    assign dout = sresult[63];
endmodule
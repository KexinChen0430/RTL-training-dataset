module DispScan
(
    input clk, en,                 
    input [3:0] in0, in1, in2, in3, 
    input indip,                   
    output reg [3:0] select, out,  
    output reg outdip              
);
    reg [1:0] state;
    localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3;
    always @ (state or en)
    begin
        if (en) 
        begin
            case (state) 
                S0: 
                    begin
                        select <= 4'b0001; 
                        out[3:0] <= in0[3:0]; 
                        outdip <= 0; 
                    end
                S1: 
                    begin
                        select <= 4'b0010; 
                        out[3:0] <= in1[3:0]; 
                        if(indip) 
                           outdip <= 1; 
                        else
                            outdip <= 0; 
                    end
                S2: 
                    begin
                        select <= 4'b0100; 
                        out[3:0] <= in2[3:0]; 
                        outdip <= 0; 
                    end
                S3: 
                    begin
                        select <= 4'b1000; 
                        out[3:0] <= in3[3:0]; 
                        outdip <= 0; 
                    end
                default: 
                    {out, outdip} = 5'b00000; 
            endcase
        end
        else 
            {select, outdip} <= 5'b00000; 
    end
    always @ (posedge clk) begin
        case (state) 
            S0: 
                state <= S1; 
            S1: 
                state <= S2; 
            S2: 
                state <= S3; 
            S3: 
                state <= S0; 
        endcase
    end
endmodule
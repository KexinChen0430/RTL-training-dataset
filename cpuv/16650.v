module Print( 
    input mclk, 
    input [15:0] num, 
    output reg [7:0] display, 
    output reg [3:0] an 
    );
    reg [3:0] tmp; 
    reg [15:0] counter; 
    parameter [15:0] MAX_COUNTER = 16'D5_0000; 
    initial begin 
        an = 4'B0111; 
        counter = 0; 
    end
    always@(posedge mclk) begin 
        counter = counter + 1; 
        if (counter == MAX_COUNTER) begin 
            an = (an >> 1) + 4'B1000; 
            if (an == 4'B1111) begin 
                an = 4'B0111; 
            end
            counter = 0; 
            case(an) 
                4'B0111: tmp = num[15:12]; 
                4'B1011: tmp = num[11:8]; 
                4'B1101: tmp = num[7:4]; 
                4'B1110: tmp = num[3:0]; 
            endcase
            case(tmp) 
            endcase
        end
    end
endmodule
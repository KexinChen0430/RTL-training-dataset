module LCD_DISPLAY_CTRL(
    PATTERN,          
    CLEAR,            
    CALLFORPATTERN,   
    mole16bit,        
    reset,            
    clk               
);
    input clk;
    input reset, CLEAR, CALLFORPATTERN;
    input [15:0] mole16bit;
    output [255:0] PATTERN;
    reg [255:0] PATTERN, next_PATTERN;
    reg [4:0] counter, next_counter;
    wire [255:0] MOLE_UPPER_PATTERN, MOLE_LOWER_PATTERN;
    wire [255:0] MALE_UPPER_PATTERN, MALE_LOWER_PATTERN;
    wire [255:0] EDGE_UPPER_PATTERN, EDGE_LOWER_PATTERN;
    always @(negedge clk or negedge reset) begin
        if (!reset) begin
            PATTERN <= 256'd0;
            counter <= 5'd31;
        end else begin
            if(!CLEAR)begin
                PATTERN <= next_PATTERN;
                counter <= next_counter;
            end else begin
                PATTERN <= 256'd0;
                counter <= 5'd31;
            end
        end
    end
    always @(*)begin
        case(counter)
            5'd0 : if(mole16bit[15]==1) next_PATTERN = MOLE_UPPER_PATTERN; else next_PATTERN = EDGE_UPPER_PATTERN;
            default: next_PATTERN = PATTERN; 
        endcase
    end
    always @( * )begin
        if(CALLFORPATTERN)
            next_counter = counter + 5'd1;
        else
            next_counter = counter;
    end
    assign MOLE_UPPER_PATTERN[255:0] = 256'hFF01_0101_0101_0101_8141_2111_0905_0303_0303_0305_0911_2141_8101_0101_0101_01FF;
    assign MOLE_LOWER_PATTERN[255:0] = 256'hFF80_8080_8080_8080_8182_8488_90A0_C0C0_C0C0_C0A0_9088_8482_8180_8080_8080_80FF;
endmodule
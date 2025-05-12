module CLS_LED_Output_Multiplexer
(
    input [9:0] PWM_CHANNEL_SIGS, 
    input PWM_TIMER_TICK,         
    input SRT_TICK,               
    output reg [9:0] LEDR,        
    input CLK                     
);
    reg [4:0] frame_pos;         
    reg [4:0] next_frame_pos;    
    reg [4:0] frame_pos_sync;    
    wire [9:0] pchs = PWM_CHANNEL_SIGS;
    initial
    begin
        frame_pos = 5'h0;        
        next_frame_pos = 5'h0;   
    end
    always @(*)
    begin
        case (frame_pos)
            5'b00000 : next_frame_pos <= 5'b00001;
            5'b00001 : next_frame_pos <= 5'b00011;
            5'b10000 : next_frame_pos <= 5'b00000;
            default : next_frame_pos <= 5'b00000; 
        endcase
    end
    always @(posedge SRT_TICK)
    begin
        frame_pos <= next_frame_pos;
    end
    always @(posedge PWM_TIMER_TICK)
    begin
        frame_pos_sync <= frame_pos;
    end
    always @*
    begin
        case (frame_pos_sync)
            5'b00000 : LEDR <= { pchs[9], pchs[8], pchs[7], pchs[6], pchs[5], pchs[4], pchs[3], pchs[2], pchs[1], pchs[0] };
            default  : LEDR <= { pchs[0], pchs[9], pchs[8], pchs[7], pchs[5], pchs[4], pchs[3], pchs[2], pchs[1], pchs[0] };
        endcase
    end
endmodule 
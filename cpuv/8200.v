module note_mono(clk, rst, note_on, note_off, note, out_note, out_gate);
parameter MAX_NOTES = 32; 
parameter MNOTES = MAX_NOTES - 1; 
parameter BIT_WIDTH  = (MAX_NOTES[7:7]==1'b1) ? 8 :
                       (MAX_NOTES[6:6]==1'b1) ? 7 :
                       (MAX_NOTES[5:5]==1'b1) ? 6 :
                       (MAX_NOTES[4:4]==1'b1) ? 5 :
                       (MAX_NOTES[3:3]==1'b1) ? 4 :
                       (MAX_NOTES[2:2]==1'b1) ? 3 :
                       (MAX_NOTES[1:1]==1'b1) ? 2 :
                       (MAX_NOTES[0:0]==1'b1) ? 1 : 0;
input wire clk, rst, note_on, note_off; 
input wire [6:0] note; 
output wire [6:0] out_note; 
output reg out_gate; 
initial out_gate <= 0; 
reg [(BIT_WIDTH-1):0] addr; 
initial addr <= 0; 
reg [BIT_WIDTH:0] top_ptr; 
initial top_ptr <= 0; 
reg [6:0] list [0:MNOTES]; 
reg [6:0] t_note; 
reg [6:0] t_out_note; 
reg [6:0] max_note; 
assign out_note = (out_gate) ? t_out_note : 7'd0; 
parameter INITIAL  = 2'd0; 
parameter NOTE_ON  = 2'd1; 
parameter NOTE_OFF = 2'd2; 
parameter READY    = 2'd3; 
reg [1:0] state; 
initial state <= INITIAL; 
parameter ST_SEARCH  = 2'd0; 
parameter IN_SEARCH  = 2'd1; 
parameter END_SEARCH = 2'd2; 
parameter GETMAX     = 2'd3; 
reg [1:0] note_on_state; 
initial note_on_state <= 0; 
reg searched; 
reg [1:0] note_off_state; 
initial note_off_state <= 0; 
always @(posedge clk) begin
    if (note_on||note_off) begin
        t_note <= note; 
    end
end
always @(posedge clk) begin
    if (rst) begin
        state<=INITIAL; 
    end else
    if (state==INITIAL) begin
        addr <= 0; 
        top_ptr <= 0; 
        out_gate <= 0; 
        state <= READY; 
    end else if (state==READY) begin
        if (note_on) begin
            state <= NOTE_ON; 
            addr <= 0; 
            searched <= 0; 
            note_on_state <= 0; 
        end else if (note_off) begin
            state <= NOTE_OFF; 
            addr <= 0; 
            searched <= 0; 
            note_off_state <= 0; 
        end
    end else if (state==NOTE_ON) begin
    end else if (state==NOTE_OFF) begin
    end
end
endmodule
module should set to high when computation should begin
    angle_in, 
    cos_out,  
    sin_out   
);
input clock;         
input reset;         
input start;         
input [31:0] angle_in; 
output [31:0] cos_out; 
output [31:0] sin_out; 
wire [31:0] cos_out = cos; 
wire [31:0] sin_out = sin; 
reg [31:0] cos;      
reg [31:0] sin;      
reg [31:0] angle;    
reg [4:0] count;     
reg state;           
reg [31:0] cos_next; 
reg [31:0] sin_next; 
reg [31:0] angle_next; 
reg [4:0] count_next; 
reg state_next;      
always @(posedge clock or posedge reset) begin
    if (reset) begin
        cos <= 0;
        sin <= 0;
        angle <= 0;
        count <= 0;
        state <= 0;
    end else begin
        cos <= cos_next;
        sin <= sin_next;
        angle <= angle_next;
        count <= count_next;
        state <= state_next;
    end
end
always @* begin
    cos_next = cos;
    sin_next = sin;
    angle_next = angle;
    count_next = count;
    state_next = state;
    if (state) begin
        cos_next = cos + (direction_negative ? sin_shr : -sin_shr);
        sin_next = sin + (direction_negative ? -cos_shr : cos_shr);
        angle_next = angle + (direction_negative ? beta : -beta);
        count_next = count + 1;
        if (count == 31) begin
            state_next = 0;
        end
    end
    else begin
        if (start) begin
            cos_next = `K;         
            sin_next = 0;          
            angle_next = angle_in; 
            count_next = 0;        
            state_next = 1;        
        end
    end
end
wire [31:0] cos_signbits = {32{cos[31]}};
wire [31:0] sin_signbits = {32{sin[31]}};
wire [31:0] cos_shr = {cos_signbits, cos} >> count;
wire [31:0] sin_shr = {sin_signbits, sin} >> count;
wire direction_negative = angle[31];
wire [31:0] beta_lut [0:31];
assign beta_lut[0] = `BETA_0;
assign beta_lut[31] = `BETA_31;
wire [31:0] beta = beta_lut[count];
endmodule
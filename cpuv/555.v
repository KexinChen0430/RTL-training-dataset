module top (
    clk,    
    led     
);
input clk;          
output [3:0] led;   
wire [3:0] led;                 
wire [7:0] pwm0_0_1_dutyCount;  
reg [7:0] pwm0_0_1_counter = 0; 
wire [7:0] pwm1_0_dutyCount;    
reg [7:0] pwm1_0_counter = 0;   
wire [7:0] pwm2_dutyCount;      
reg [7:0] pwm2_counter = 0;     
wire [7:0] pwm3_dutyCount;      
reg [7:0] pwm3_counter = 0;     
reg led_i [0:4-1];              
initial begin: INITIALIZE_LED_I
    integer i;
    for(i=0; i<4; i=i+1) begin
        led_i[i] = 0;
    end
end
assign pwm0_0_1_dutyCount = 8'd4;   
assign pwm1_0_dutyCount = 8'd16;    
assign pwm2_dutyCount = 8'd64;      
assign pwm3_dutyCount = 8'd255;     
always @(posedge clk) begin: TOP_PWM0_0_1_LOGIC
    pwm0_0_1_counter <= (pwm0_0_1_counter + 1); 
    led_i[0] <= (pwm0_0_1_counter < pwm0_0_1_dutyCount); 
end
always @(posedge clk) begin: TOP_PWM1_0_LOGIC
    pwm1_0_counter <= (pwm1_0_counter + 1); 
    led_i[1] <= (pwm1_0_counter < pwm1_0_dutyCount); 
end
always @(posedge clk) begin: TOP_PWM2_LOGIC
    pwm2_counter <= (pwm2_counter + 1); 
    led_i[2] <= (pwm2_counter < pwm2_dutyCount); 
end
always @(posedge clk) begin: TOP_PWM3_LOGIC
    pwm3_counter <= (pwm3_counter + 1); 
    led_i[3] <= (pwm3_counter < pwm3_dutyCount); 
end
assign led = {led_i[3], led_i[2], led_i[1], led_i[0]}; 
endmodule 
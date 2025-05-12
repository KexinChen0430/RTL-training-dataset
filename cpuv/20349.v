module Altera_UP_I2C (
    clk,                        
    reset,                      
    clear_ack,                  
    clk_400KHz,                 
    start_and_stop_en,          
    change_output_bit_en,       
    send_start_bit,             
    send_stop_bit,              
    data_in,                    
    transfer_data,              
    read_byte,                  
    num_bits_to_transfer,       
    i2c_sdata,                  
    i2c_sclk,                   
    i2c_scen,                   
    enable_clk,                 
    ack,                        
    data_from_i2c,              
    transfer_complete           
);
parameter I2C_BUS_MODE = 1'b0;
input               clk;
input               reset;
input               clear_ack;
input               clk_400KHz;
input               start_and_stop_en;
input               change_output_bit_en;
input               send_start_bit;
input               send_stop_bit;
input       [7:0]   data_in;
input               transfer_data;
input               read_byte;
input       [2:0]   num_bits_to_transfer;
inout               i2c_sdata;                  
output              i2c_sclk;                   
output  reg         i2c_scen;                   
output              enable_clk;                 
output  reg         ack;                        
output  reg [7:0]   data_from_i2c;              
output              transfer_complete;          
localparam  I2C_STATE_0_IDLE            = 3'h0,
            I2C_STATE_1_PRE_START       = 3'h1,
            I2C_STATE_2_START_BIT       = 3'h2,
            I2C_STATE_3_TRANSFER_BYTE   = 3'h3,
            I2C_STATE_4_TRANSFER_ACK    = 3'h4,
            I2C_STATE_5_STOP_BIT        = 3'h5,
            I2C_STATE_6_COMPLETE        = 3'h6;
reg         [2:0]   current_bit;
reg         [7:0]   current_byte;
reg         [2:0]   ns_i2c_transceiver; 
reg         [2:0]   s_i2c_transceiver;  
always @(posedge clk)
begin
    if (reset == 1'b1)
        s_i2c_transceiver <= I2C_STATE_0_IDLE; 
    else
        s_i2c_transceiver <= ns_i2c_transceiver; 
end
always @(*)
begin
    ns_i2c_transceiver = I2C_STATE_0_IDLE;
    case (s_i2c_transceiver)
    endcase
end
always @(posedge clk)
begin
end
always @(posedge clk)
begin
end
always @(posedge clk)
begin
end
always @(posedge clk)
begin
end
always @(posedge clk)
begin
end
assign i2c_sclk     = 
assign i2c_sdata    = 
assign enable_clk   = 
assign transfer_complete =
        (s_i2c_transceiver == I2C_STATE_6_COMPLETE) ? 1'b1 : 1'b0;
endmodule
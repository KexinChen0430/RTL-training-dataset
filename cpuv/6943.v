module fan_motor_driver(
    input                   rsi_MRST_reset,        
    input                   csi_MCLK_clk,          
    input       [31:0]      avs_ctrl_writedata,    
    output  [31:0]      avs_ctrl_readdata,     
    input       [3:0]       avs_ctrl_byteenable,   
    input       [2:0]       avs_ctrl_address,      
    input                   avs_ctrl_write,        
    input                   avs_ctrl_read,         
    output              avs_ctrl_waitrequest,  
    input                   rsi_PWMRST_reset,      
    input                   csi_PWMCLK_clk,        
    output fan                                   
    );
reg on_off;                                     
reg [31:0] PWM_width;                           
reg [31:0] PWM_frequent;                        
reg [31:0] read_data;                           
assign  avs_ctrl_readdata = read_data;          
always@(posedge csi_MCLK_clk or posedge rsi_MRST_reset)
begin
    if(rsi_MRST_reset) begin
        read_data <= 0;                         
    end
    else if(avs_ctrl_write)
    begin
        case(avs_ctrl_address)
            1: begin
                if(avs_ctrl_byteenable[3]) PWM_frequent[31:24] <= avs_ctrl_writedata[31:24];
                if(avs_ctrl_byteenable[2]) PWM_frequent[23:16] <= avs_ctrl_writedata[23:16];
                if(avs_ctrl_byteenable[1]) PWM_frequent[15:8] <= avs_ctrl_writedata[15:8];
                if(avs_ctrl_byteenable[0]) PWM_frequent[7:0] <= avs_ctrl_writedata[7:0];
            end
            2: begin
                if(avs_ctrl_byteenable[3]) PWM_width[31:24] <= avs_ctrl_writedata[31:24];
                if(avs_ctrl_byteenable[2]) PWM_width[23:16] <= avs_ctrl_writedata[23:16];
                if(avs_ctrl_byteenable[1]) PWM_width[15:8] <= avs_ctrl_writedata[15:8];
                if(avs_ctrl_byteenable[0]) PWM_width[7:0] <= avs_ctrl_writedata[7:0];
            end
            3: on_off <= avs_ctrl_writedata[0];   
            default:;
        endcase
    end
    else begin
        case(avs_ctrl_address)
            0: read_data <= 32'hEA680003;         
            1: read_data <= PWM_frequent;          
            2: read_data <= PWM_width;             
            3: read_data <= {31'b0,on_off};        
            default: read_data <= 32'b0;            
        endcase
    end
end
reg [31:0] PWM;                                  
reg PWM_out;                                     
always @ (posedge csi_PWMCLK_clk or posedge rsi_PWMRST_reset)
begin
    if(rsi_PWMRST_reset)
        PWM <= 32'b0;                            
    else
    begin
        PWM <= PWM + PWM_frequent;               
        PWM_out <=(PWM > PWM_width) ? 0:1;       
    end
end
assign fan = on_off ? PWM_out : 0;               
endmodule
module CPC2(
    input FPGA_CLK1_50,          
    input FPGA_CLK2_50,          
    input FPGA_CLK3_50,          
    inout HDMI_I2C_SCL,          
    inout HDMI_I2C_SDA,          
    inout HDMI_I2S,              
    inout HDMI_LRCLK,            
    inout HDMI_MCLK,             
    inout HDMI_SCLK,             
    output HDMI_TX_CLK,          
    output HDMI_TX_DE,           
    output [23:0] HDMI_TX_D,     
    output HDMI_TX_HS,           
    input HDMI_TX_INT,           
    output HDMI_TX_VS,           
    input [1:0] KEY,             
    output [7:0] LED,            
    input [3:0] SW               
);
endmodule
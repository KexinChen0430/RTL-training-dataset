module DE0_Nano(
    CLOCK_50,
    LED,
    KEY,
    SW,
    DRAM_ADDR,
    DRAM_BA,
    DRAM_CAS_N,
    DRAM_CKE,
    DRAM_CLK,
    DRAM_CS_N,
    DRAM_DQ,
    DRAM_DQM,
    DRAM_RAS_N,
    DRAM_WE_N,
    EPCS_ASDO,
    EPCS_DATA0,
    EPCS_DCLK,
    EPCS_NCSO,
    G_SENSOR_CS_N,
    G_SENSOR_INT,
    I2C_SCLK,
    I2C_SDAT,
    ADC_CS_N,
    ADC_SADDR,
    ADC_SCLK,
    ADC_SDAT,
    GPIO_2,
    GPIO_2_IN,
    GPIO_0,
    GPIO_0_IN,
    GPIO_1,
    GPIO_1_IN
);
input                       CLOCK_50;
output          [7:0]       LED;
input           [1:0]       KEY;
input           [3:0]       SW;
output          [12:0]      DRAM_ADDR;
output           [1:0]      DRAM_BA;
output                       DRAM_CAS_N;
output                       DRAM_CKE;
output                       DRAM_CLK;
output                       DRAM_CS_N;
inout           [15:0]      DRAM_DQ;
output           [1:0]      DRAM_DQM;
output                       DRAM_RAS_N;
output                       DRAM_WE_N;
output                       EPCS_ASDO;
input                        EPCS_DATA0;
output                       EPCS_DCLK;
output                       EPCS_NCSO;
output                       G_SENSOR_CS_N;
input                        G_SENSOR_INT;
output                       I2C_SCLK;
inout                        I2C_SDAT;
output                       ADC_CS_N;
output                       ADC_SADDR;
output                       ADC_SCLK;
input                        ADC_SDAT;
inout           [12:0]      GPIO_2;
input           [2:0]       GPIO_2_IN;
inout           [33:0]      GPIO_0;
inout           [1:0]       GPIO_0_IN;
inout           [33:0]      GPIO_1;
input           [1:0]       GPIO_1_IN;
wire            [0:3]       seconds;
wire            [0:3]       tens_seconds;
wire            [0:3]       minutes;
wire            [0:3]       tens_minutes;
wire            [0:3]       hours;
wire            [0:3]       tens_hours;
wire                          AM;
wire                          PM;
wire                          seconds_tick;
assign GPIO_0_IN[1]     =   seconds[0];
assign GPIO_0[1:3]      =   seconds[1:3];
assign GPIO_0[4:7]      =   tens_seconds[0:3];
assign GPIO_0[8:11]     =   minutes[0:3];
assign GPIO_0[12:15]    =   tens_minutes[0:3];
assign GPIO_0[16:19]    =   hours[0:3];
assign GPIO_0[20:23]    =   tens_hours[0:3];
assign GPIO_0[24]       =   AM;
assign GPIO_0[25]       =   PM;
assign GPIO_0[26]       =   seconds_tick;
endmodule
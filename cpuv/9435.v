module prcfg ( 
  input                 clk, 
  input       [31:0]    adc_gpio_input, 
  output      [31:0]    adc_gpio_output, 
  input       [31:0]    dac_gpio_input, 
  output      [31:0]    dac_gpio_output, 
  output                dma_dac_en, 
  input                 dma_dac_dunf, 
  input       [63:0]    dma_dac_ddata, 
  input                 dma_dac_dvalid, 
  input                 core_dac_en, 
  output                core_dac_dunf, 
  output      [63:0]    core_dac_ddata, 
  output                core_dac_dvalid, 
  input                 core_adc_dwr, 
  input                 core_adc_dsync, 
  input       [63:0]    core_adc_ddata, 
  output                core_adc_ovf, 
  output                dma_adc_dwr, 
  output                dma_adc_dsync, 
  output      [63:0]    dma_adc_ddata, 
  input                 dma_adc_ovf 
);
endmodule 
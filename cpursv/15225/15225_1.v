
module soc_system(cart_io_ad_in,cart_io_ad_out,cart_io_ad_outen,cart_io_ale_h,
                  cart_io_ale_l,cart_io_read_n,cart_io_write_n,
                  cart_led_out_led_read,cart_led_out_led_write,clk_clk,
                  hps_io_hps_io_emac1_inst_TX_CLK,hps_io_hps_io_emac1_inst_TXD0,
                  hps_io_hps_io_emac1_inst_TXD1,hps_io_hps_io_emac1_inst_TXD2,
                  hps_io_hps_io_emac1_inst_TXD3,hps_io_hps_io_emac1_inst_RXD0,
                  hps_io_hps_io_emac1_inst_MDIO,hps_io_hps_io_emac1_inst_MDC,
                  hps_io_hps_io_emac1_inst_RX_CTL,
                  hps_io_hps_io_emac1_inst_TX_CTL,
                  hps_io_hps_io_emac1_inst_RX_CLK,hps_io_hps_io_emac1_inst_RXD1,
                  hps_io_hps_io_emac1_inst_RXD2,hps_io_hps_io_emac1_inst_RXD3,
                  hps_io_hps_io_sdio_inst_CMD,hps_io_hps_io_sdio_inst_D0,
                  hps_io_hps_io_sdio_inst_D1,hps_io_hps_io_sdio_inst_CLK,
                  hps_io_hps_io_sdio_inst_D2,hps_io_hps_io_sdio_inst_D3,
                  hps_io_hps_io_usb1_inst_D0,hps_io_hps_io_usb1_inst_D1,
                  hps_io_hps_io_usb1_inst_D2,hps_io_hps_io_usb1_inst_D3,
                  hps_io_hps_io_usb1_inst_D4,hps_io_hps_io_usb1_inst_D5,
                  hps_io_hps_io_usb1_inst_D6,hps_io_hps_io_usb1_inst_D7,
                  hps_io_hps_io_usb1_inst_CLK,hps_io_hps_io_usb1_inst_STP,
                  hps_io_hps_io_usb1_inst_DIR,hps_io_hps_io_usb1_inst_NXT,
                  hps_io_hps_io_spim1_inst_CLK,hps_io_hps_io_spim1_inst_MOSI,
                  hps_io_hps_io_spim1_inst_MISO,hps_io_hps_io_spim1_inst_SS0,
                  hps_io_hps_io_uart0_inst_RX,hps_io_hps_io_uart0_inst_TX,
                  hps_io_hps_io_i2c0_inst_SDA,hps_io_hps_io_i2c0_inst_SCL,
                  hps_io_hps_io_i2c1_inst_SDA,hps_io_hps_io_i2c1_inst_SCL,
                  hps_io_hps_io_gpio_inst_GPIO09,hps_io_hps_io_gpio_inst_GPIO35,
                  hps_io_hps_io_gpio_inst_GPIO40,hps_io_hps_io_gpio_inst_GPIO53,
                  hps_io_hps_io_gpio_inst_GPIO54,hps_io_hps_io_gpio_inst_GPIO61,
                  memory_mem_a,memory_mem_ba,memory_mem_ck,memory_mem_ck_n,
                  memory_mem_cke,memory_mem_cs_n,memory_mem_ras_n,
                  memory_mem_cas_n,memory_mem_we_n,memory_mem_reset_n,
                  memory_mem_dq,memory_mem_dqs,memory_mem_dqs_n,memory_mem_odt,
                  memory_mem_dm,memory_oct_rzqin,reset_reset_n);

  input  [15:0] cart_io_ad_in;
  output [15:0] cart_io_ad_out;
  output cart_io_ad_outen;
  output cart_io_ale_h;
  output cart_io_ale_l;
  output cart_io_read_n;
  output cart_io_write_n;
  output cart_led_out_led_read;
  output cart_led_out_led_write;
  input  clk_clk;
  output hps_io_hps_io_emac1_inst_TX_CLK;
  output hps_io_hps_io_emac1_inst_TXD0;
  output hps_io_hps_io_emac1_inst_TXD1;
  output hps_io_hps_io_emac1_inst_TXD2;
  output hps_io_hps_io_emac1_inst_TXD3;
  input  hps_io_hps_io_emac1_inst_RXD0;
  inout  hps_io_hps_io_emac1_inst_MDIO;
  output hps_io_hps_io_emac1_inst_MDC;
  input  hps_io_hps_io_emac1_inst_RX_CTL;
  output hps_io_hps_io_emac1_inst_TX_CTL;
  input  hps_io_hps_io_emac1_inst_RX_CLK;
  input  hps_io_hps_io_emac1_inst_RXD1;
  input  hps_io_hps_io_emac1_inst_RXD2;
  input  hps_io_hps_io_emac1_inst_RXD3;
  inout  hps_io_hps_io_sdio_inst_CMD;
  inout  hps_io_hps_io_sdio_inst_D0;
  inout  hps_io_hps_io_sdio_inst_D1;
  output hps_io_hps_io_sdio_inst_CLK;
  inout  hps_io_hps_io_sdio_inst_D2;
  inout  hps_io_hps_io_sdio_inst_D3;
  inout  hps_io_hps_io_usb1_inst_D0;
  inout  hps_io_hps_io_usb1_inst_D1;
  inout  hps_io_hps_io_usb1_inst_D2;
  inout  hps_io_hps_io_usb1_inst_D3;
  inout  hps_io_hps_io_usb1_inst_D4;
  inout  hps_io_hps_io_usb1_inst_D5;
  inout  hps_io_hps_io_usb1_inst_D6;
  inout  hps_io_hps_io_usb1_inst_D7;
  input  hps_io_hps_io_usb1_inst_CLK;
  output hps_io_hps_io_usb1_inst_STP;
  input  hps_io_hps_io_usb1_inst_DIR;
  input  hps_io_hps_io_usb1_inst_NXT;
  output hps_io_hps_io_spim1_inst_CLK;
  output hps_io_hps_io_spim1_inst_MOSI;
  input  hps_io_hps_io_spim1_inst_MISO;
  output hps_io_hps_io_spim1_inst_SS0;
  input  hps_io_hps_io_uart0_inst_RX;
  output hps_io_hps_io_uart0_inst_TX;
  inout  hps_io_hps_io_i2c0_inst_SDA;
  inout  hps_io_hps_io_i2c0_inst_SCL;
  inout  hps_io_hps_io_i2c1_inst_SDA;
  inout  hps_io_hps_io_i2c1_inst_SCL;
  inout  hps_io_hps_io_gpio_inst_GPIO09;
  inout  hps_io_hps_io_gpio_inst_GPIO35;
  inout  hps_io_hps_io_gpio_inst_GPIO40;
  inout  hps_io_hps_io_gpio_inst_GPIO53;
  inout  hps_io_hps_io_gpio_inst_GPIO54;
  inout  hps_io_hps_io_gpio_inst_GPIO61;
  output [14:0] memory_mem_a;
  output [2:0] memory_mem_ba;
  output memory_mem_ck;
  output memory_mem_ck_n;
  output memory_mem_cke;
  output memory_mem_cs_n;
  output memory_mem_ras_n;
  output memory_mem_cas_n;
  output memory_mem_we_n;
  output memory_mem_reset_n;
  inout  [31:0] memory_mem_dq;
  inout  [3:0] memory_mem_dqs;
  inout  [3:0] memory_mem_dqs_n;
  output memory_mem_odt;
  output [3:0] memory_mem_dm;
  input  memory_oct_rzqin;
  input  reset_reset_n;


endmodule


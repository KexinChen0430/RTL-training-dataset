module etx_cfg (
   mi_dout, tx_enable, mmu_enable, gpio_enable, remap_enable,
   gpio_data, ctrlmode, ctrlmode_bypass,
   reset, clk, mi_en, mi_we, mi_addr, mi_din, tx_status
   );
   parameter PW               = 104;          
   parameter RFAW             = 6;            
   parameter DEFAULT_VERSION  = 16'h0000;     
   input reset;
   input clk;
   input mi_en;                              
   input mi_we;                              
   input [RFAW+1:0] mi_addr;                
   input [31:0] mi_din;                     
   output [31:0] mi_dout;                   
   output tx_enable;                         
   output mmu_enable;                        
   output gpio_enable;                       
   output remap_enable;                      
   input [15:0] tx_status;                   
   output [8:0] gpio_data;                   
   output [3:0] ctrlmode;                    
   output ctrlmode_bypass;                   
   reg [15:0] ecfg_version_reg;              
   reg [10:0] ecfg_tx_config_reg;            
   reg [8:0] ecfg_tx_gpio_reg;               
   reg [2:0] ecfg_tx_status_reg;             
   reg [31:0] mi_dout;                       
   reg ecfg_access;                          
   wire ecfg_read;                           
   wire ecfg_write;                          
   wire ecfg_tx_config_write;                
   wire ecfg_tx_gpio_write;                  
   wire ecfg_tx_test_write;                  
   wire ecfg_tx_addr_write;                  
   wire ecfg_tx_data_write;                  
   wire loop_mode;                           
   assign ecfg_write = mi_en & mi_we;
   assign ecfg_read = mi_en & ~mi_we;
   assign ecfg_version_write   = ecfg_write & (mi_addr[RFAW+1:2]==`E_VERSION);
   assign ecfg_tx_config_write = ecfg_write & (mi_addr[RFAW+1:2]==`ETX_CFG);
   assign ecfg_tx_status_write = ecfg_write & (mi_addr[RFAW+1:2]==`ETX_STATUS);
   assign ecfg_tx_gpio_write   = ecfg_write & (mi_addr[RFAW+1:2]==`ETX_GPIO);
   always @ (posedge clk)
     if(reset)
       ecfg_tx_config_reg[10:0] <= 11'b0;
     else if (ecfg_tx_config_write)
       ecfg_tx_config_reg[10:0] <= mi_din[10:0];
   assign tx_enable       = 1'b1; 
   assign mmu_enable      = ecfg_tx_config_reg[1];
   assign remap_enable    = ecfg_tx_config_reg[3:2]==2'b01;
   assign ctrlmode[3:0]   = ecfg_tx_config_reg[7:4];
   assign ctrlmode_bypass = ecfg_tx_config_reg[8];
   assign gpio_enable     = (ecfg_tx_config_reg[10:9]==2'b01);
   always @ (posedge clk)
     if(reset)
       ecfg_tx_status_reg[2:0] <= 'd0;
     else
       ecfg_tx_status_reg[2:0] <= ecfg_tx_status_reg[2:0] | tx_status[2:0];
   always @ (posedge clk)
     if(reset)
       ecfg_tx_gpio_reg[8:0] <= 'd0;
     else if (ecfg_tx_gpio_write)
       ecfg_tx_gpio_reg[8:0] <= mi_din[8:0];
   assign gpio_data[8:0] = ecfg_tx_gpio_reg[8:0];
   always @ (posedge clk)
     if(reset)
       ecfg_version_reg[15:0] <= DEFAULT_VERSION;
     else if (ecfg_version_write)
       ecfg_version_reg[15:0] <= mi_din[15:0];
   always @ (posedge clk)
     if(ecfg_read)
       case(mi_addr[RFAW+1:2])
         `ETX_CFG:    mi_dout[31:0] <= {21'b0, ecfg_tx_config_reg[10:0]};
         `ETX_GPIO:   mi_dout[31:0] <= {23'b0, ecfg_tx_gpio_reg[8:0]};
         `ETX_STATUS: mi_dout[31:0] <= {16'b0, tx_status[15:3], ecfg_tx_status_reg[2:0]};
         `E_VERSION:  mi_dout[31:0] <= {16'b0, ecfg_version_reg[15:0]};
         default:     mi_dout[31:0] <= 32'd0;
       endcase
     else
       mi_dout[31:0] <= 32'd0;
endmodule 
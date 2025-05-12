module erx_cfg (
   mi_dout, rx_enable, mmu_enable, remap_mode, remap_base,
   remap_pattern, remap_sel, timer_cfg,
   reset, clk, mi_en, mi_we, mi_addr, mi_din, gpio_datain, rx_status
   );
   parameter RFAW            = 6;         
   parameter GROUP           = 4'h0;
   input 	reset;       
   input 	clk;
   input 	 mi_en;
   input 	 mi_we;            
   input [14:0]  mi_addr;          
   input [31:0]  mi_din;
   output [31:0] mi_dout;
   output 	 rx_enable;      
   output 	 mmu_enable;     
   input [8:0] 	 gpio_datain;    
   input [15:0]  rx_status;      
   output [1:0]  remap_mode;     
   output [31:0] remap_base;     
   output [11:0] remap_pattern;  
   output [11:0] remap_sel;      
   output [1:0]  timer_cfg;      
   reg [31:0] 	ecfg_rx_reg;
   reg [31:0] 	ecfg_offset_reg;
   reg [8:0] 	ecfg_gpio_reg;
   reg [2:0] 	ecfg_rx_status_reg;
   reg [31:0] 	mi_dout;
   wire 	ecfg_read;
   wire 	ecfg_write;
   wire 	ecfg_rx_write;
   wire  	ecfg_base_write;
   wire  	ecfg_remap_write;
   assign ecfg_write  = mi_en &  mi_we;
   assign ecfg_read   = mi_en & ~mi_we;
   assign ecfg_rx_write      = ecfg_write & (mi_addr[RFAW+1:2]==`ERX_CFG);
   assign ecfg_base_write    = ecfg_write & (mi_addr[RFAW+1:2]==`ERX_OFFSET);
   always @ (posedge clk)
     if(reset)
       ecfg_rx_reg[31:0] <= 'b0;
     else if (ecfg_rx_write)
       ecfg_rx_reg[31:0] <= mi_din[31:0];
   assign rx_enable           = 1'b1;
   assign mmu_enable          = ecfg_rx_reg[1];
   assign remap_mode[1:0]     = ecfg_rx_reg[3:2];
   assign remap_sel[11:0]     = ecfg_rx_reg[15:4];
   assign remap_pattern[11:0] = ecfg_rx_reg[27:16];
   assign timer_cfg[1:0]      = ecfg_rx_reg[29:28];
   always @ (posedge clk)
     ecfg_gpio_reg[8:0] <= gpio_datain[8:0];
   always @ (posedge clk)
     if(reset)
       ecfg_rx_status_reg[2:0] <= 'b0;
     else
       ecfg_rx_status_reg[2:0] <= ecfg_rx_status_reg[2:0] | rx_status[2:0];
   always @ (posedge clk)
     if (ecfg_base_write)
       ecfg_offset_reg[31:0] <= mi_din[31:0];
   assign remap_base[31:0] = ecfg_offset_reg[31:0];
   always @ (posedge clk)
     if(ecfg_read)
       case(mi_addr[RFAW+1:2])
         `ERX_CFG:     mi_dout[31:0] <= {ecfg_rx_reg[31:0]};
         `ERX_GPIO:    mi_dout[31:0] <= {23'b0, ecfg_gpio_reg[8:0]};
	 `ERX_STATUS:  mi_dout[31:0] <= {16'b0, rx_status[15:3],ecfg_rx_status_reg[2:0]};
	 `ERX_OFFSET:  mi_dout[31:0] <= {ecfg_offset_reg[31:0]};
         default:      mi_dout[31:0] <= 32'd0;
       endcase 
     else
       mi_dout[31:0] <= 32'd0;
endmodule
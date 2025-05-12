module erx_cfg (
   mi_dout, rx_enable, mmu_enable, remap_mode, remap_base,
   remap_pattern, remap_sel, timer_cfg, idelay_value, load_taps,
   test_mode,
   reset, clk, mi_en, mi_we, mi_addr, mi_din, erx_test_access,
   erx_test_data, gpio_datain, rx_status
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
   input 	 erx_test_access;
   input [31:0]  erx_test_data;
   output 	 rx_enable;      
   output 	 mmu_enable;     
   input [8:0] 	 gpio_datain;    
   input [15:0]  rx_status;      
   output [1:0]  remap_mode;     
   output [31:0] remap_base;     
   output [11:0] remap_pattern;  
   output [11:0] remap_sel;      
   output [1:0]  timer_cfg;      
   output [44:0] idelay_value;   
   output        load_taps;      
   output 	 test_mode;      
   reg [31:0] 	ecfg_rx_reg;
   reg [31:0] 	ecfg_offset_reg;
   reg [8:0] 	ecfg_gpio_reg;
   reg [2:0] 	ecfg_rx_status_reg;
   reg [63:0] 	ecfg_idelay_reg;
   reg 		load_taps;
   reg [31:0] 	mi_dout;
   reg [31:0] 	ecfg_testdata_reg;
   wire 	ecfg_read;
   wire 	ecfg_write;
   wire 	ecfg_rx_write;
   wire  	ecfg_offset_write;
   wire  	ecfg_remap_write;
   wire  	ecfg_idelay0_write;
   wire  	ecfg_idelay1_write;
   wire         ecfg_testdata_write;
   assign ecfg_write  = mi_en &  mi_we;
   assign ecfg_read   = mi_en & ~mi_we;
   assign ecfg_rx_write       = ecfg_write & (mi_addr[RFAW+1:2]==`ERX_CFG);
   assign ecfg_offset_write   = ecfg_write & (mi_addr[RFAW+1:2]==`ERX_OFFSET);
   assign ecfg_idelay0_write  = ecfg_write & (mi_addr[RFAW+1:2]==`ERX_IDELAY0);
   assign ecfg_idelay1_write  = ecfg_write & (mi_addr[RFAW+1:2]==`ERX_IDELAY1);
   assign ecfg_testdata_write = ecfg_write & (mi_addr[RFAW+1:2]==`ERX_TESTDATA);
   always @ (posedge clk or posedge reset)
     if(reset)
       ecfg_rx_reg[31:0] <= 'b0;
     else if (ecfg_rx_write)
       ecfg_rx_reg[31:0] <= mi_din[31:0];
   assign test_mode           = ecfg_rx_reg[0];
   assign mmu_enable          = ecfg_rx_reg[1];
   assign remap_mode[1:0]     = ecfg_rx_reg[3:2];
   assign remap_sel[11:0]     = ecfg_rx_reg[15:4];
   assign remap_pattern[11:0] = ecfg_rx_reg[27:16];
   assign timer_cfg[1:0]      = ecfg_rx_reg[29:28];
   always @ (posedge clk)
     ecfg_gpio_reg[8:0] <= gpio_datain[8:0];
   always @ (posedge clk or posedge reset)
     if(reset)
       ecfg_rx_status_reg[2:0] <= 'b0;
     else
       ecfg_rx_status_reg[2:0] <= ecfg_rx_status_reg[2:0] | rx_status[2:0];
   always @ (posedge clk)
     if (ecfg_offset_write)
       ecfg_offset_reg[31:0] <= mi_din[31:0];
   assign remap_base[31:0] = ecfg_offset_reg[31:0];
   always @ (posedge clk or posedge reset)
     if(reset)
       ecfg_idelay_reg[63:0]  <= 'b0;
     else if (ecfg_idelay0_write)
       ecfg_idelay_reg[31:0]  <= mi_din[31:0];
     else if(ecfg_idelay1_write)
       ecfg_idelay_reg[63:32] <= mi_din[31:0];
   assign idelay_value[44:0] = {ecfg_idelay_reg[46:32],ecfg_idelay_reg[29:0]};
   always @ (posedge clk)
     load_taps <= ecfg_idelay1_write;
   always @ (posedge clk)
     if(ecfg_testdata_write)
       ecfg_testdata_reg[31:0] <= mi_din[31:0];
     else if(erx_test_access)
       ecfg_testdata_reg[31:0] <= ecfg_testdata_reg[31:0] + erx_test_data[31:0];
   always @ (posedge clk)
     if(ecfg_read)
       case(mi_addr[RFAW+1:2])
         `ERX_CFG:      mi_dout[31:0] <= {ecfg_rx_reg[31:0]};
         `ERX_GPIO:     mi_dout[31:0] <= {23'b0, ecfg_gpio_reg[8:0]};
	 `ERX_STATUS:   mi_dout[31:0] <= {16'b0, rx_status[15:3],ecfg_rx_status_reg[2:0]};
	 `ERX_OFFSET:   mi_dout[31:0] <= {ecfg_offset_reg[31:0]};
	 `ERX_TESTDATA: mi_dout[31:0] <= {ecfg_testdata_reg[31:0]};
         default:       mi_dout[31:0] <= 32'd0;
       endcase 
     else
       mi_dout[31:0] <= 32'd0;
endmodule
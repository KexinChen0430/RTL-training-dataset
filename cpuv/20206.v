module ecfg_elink (
   txwr_gated_access, etx_soft_reset, erx_soft_reset, clk_config,
   chipid,
   clk, por_reset, txwr_access, txwr_packet
   );
   parameter RFAW             = 6;     
   parameter PW               = 104;   
   parameter ID               = 12'h000;
   parameter DEFAULT_CHIPID   = 12'h808;
   input 	  clk;
   input 	  por_reset;       
   input 	  txwr_access;
   input [PW-1:0] txwr_packet;
   output 	  txwr_gated_access;
   output 	 etx_soft_reset;  
   output 	 erx_soft_reset;  
   output [15:0] clk_config;      
   output [11:0] chipid;          
   reg [1:0] 	ecfg_reset_reg;
   reg [15:0] 	ecfg_clk_reg;
   reg [11:0] 	ecfg_chipid_reg;
   reg [31:0] 	mi_dout;
   wire 	ecfg_read;
   wire 	ecfg_write;
   wire 	ecfg_clk_write;
   wire 	ecfg_chipid_write;
   wire 	ecfg_reset_write;
   wire 	mi_en;
   wire [31:0] 	mi_addr;
   wire [31:0] 	mi_din;
   packet2emesh pe2 (
		     .access_out	(),
		     .write_out		(mi_we),
		     .datamode_out	(),
		     .ctrlmode_out	(),
		     .dstaddr_out	(mi_addr[31:0]),
		     .data_out		(mi_din[31:0]),
		     .srcaddr_out	(),
		     .packet_in		(txwr_packet[PW-1:0])
		     );
   assign mi_en = txwr_access &
		  (mi_addr[31:20]==ID) &
		  (mi_addr[10:8]==3'h2);
   assign ecfg_write  = mi_en &  mi_we;
   assign ecfg_read   = mi_en & ~mi_we;
   assign ecfg_reset_write    = ecfg_write & (mi_addr[RFAW+1:2]==`E_RESET);
   assign ecfg_clk_write      = ecfg_write & (mi_addr[RFAW+1:2]==`E_CLK);
   assign ecfg_chipid_write   = ecfg_write & (mi_addr[RFAW+1:2]==`E_CHIPID);
   assign 	txwr_gated_access =  txwr_access & ~(ecfg_reset_write |
						     ecfg_clk_write   |
                                                     ecfg_chipid_write);
    always @ (posedge clk or posedge por_reset)
      if(por_reset)
	ecfg_reset_reg[1:0] <= 'b0;
      else if (ecfg_reset_write)
	ecfg_reset_reg[1:0] <= mi_din[1:0];
   assign etx_soft_reset  = ecfg_reset_reg[0];
   assign erx_soft_reset  = ecfg_reset_reg[1];
    always @ (posedge clk or posedge por_reset)
     if(por_reset)
       ecfg_clk_reg[15:0] <= 16'h573;
     else if (ecfg_clk_write)
       ecfg_clk_reg[15:0] <= mi_din[15:0];
   assign clk_config[15:0] = ecfg_clk_reg[15:0];
   always @ (posedge clk or posedge por_reset)
     if(por_reset)
       ecfg_chipid_reg[11:0] <= DEFAULT_CHIPID;
     else if (ecfg_chipid_write)
       ecfg_chipid_reg[11:0] <= mi_din[11:0];
   assign chipid[11:0]=ecfg_chipid_reg[5:2];
endmodule
module emon (
   mi_data_out, mi_data_sel, emon_zero_flag,
   clk, reset, mi_access, mi_write, mi_addr, mi_data_in,
   erx_rdfifo_access, erx_rdfifo_wait, erx_wrfifo_access,
   erx_wrfifo_wait, erx_wbfifo_access, erx_wbfifo_wait,
   etx_rdfifo_access, etx_rdfifo_wait, etx_wrfifo_access,
   etx_wrfifo_wait, etx_wbfifo_access, etx_wbfifo_wait
   );
   parameter DW   = 32; 
   parameter MONS = 6;  
   input               clk; 
   input               reset; 
   input               mi_access; 
   input               mi_write; 
   input  [19:0]       mi_addr; 
   input  [DW-1:0]     mi_data_in; 
   output [DW-1:0]     mi_data_out; 
   output              mi_data_sel;  
   input 	     erx_rdfifo_access; 
   input 	     erx_rdfifo_wait; 
   input 	     erx_wrfifo_access; 
   input 	     erx_wrfifo_wait; 
   input 	     erx_wbfifo_access; 
   input 	     erx_wbfifo_wait; 
   input 	     etx_rdfifo_access; 
   input 	     etx_rdfifo_wait; 
   input 	     etx_wrfifo_access; 
   input 	     etx_wrfifo_wait; 
   input 	     etx_wbfifo_access; 
   input 	     etx_wbfifo_wait; 
   output [5:0]      emon_zero_flag; 
   wire 	     emon_read; 
   wire [5:0]        emon_mon_match; 
   wire 	     emon_cfg_match; 
   wire 	     emon_match; 
   wire [5:0] 	     emon_write; 
   wire 	     emon_cfg_write; 
   reg [DW-1:0]      emon_reg_mux; 
   wire [15:0] 	     emon_vector; 
   wire[DW-1:0]      emon_reg[5:0]; 
   reg [DW-1:0]      mi_data_out; 
   reg [DW-1:0]      emon_cfg_reg; 
   assign emon_read         = mi_access & ~mi_write; 
   assign emon_cfg_match    = mi_addr[19:0]==`E_REG_SYSMONCFG; 
   assign emon_mon_match[0]    = mi_addr[19:0]==`E_REG_SYSRXMON0; 
   assign emon_mon_match[1]    = mi_addr[19:0]==`E_REG_SYSRXMON1;
   assign emon_mon_match[2]    = mi_addr[19:0]==`E_REG_SYSRXMON2;
   assign emon_mon_match[3]    = mi_addr[19:0]==`E_REG_SYSTXMON0;
   assign emon_mon_match[4]    = mi_addr[19:0]==`E_REG_SYSTXMON1;
   assign emon_mon_match[5]    = mi_addr[19:0]==`E_REG_SYSTXMON2;
   assign emon_write[0]     =  emon_match[0]  & mi_write & mi_access; 
   assign emon_write[1]     =  emon_match[1]  & mi_write & mi_access;
   assign emon_write[2]     =  emon_match[2]  & mi_write & mi_access;
   assign emon_write[3]     =  emon_match[3]  & mi_write & mi_access;
   assign emon_write[4]     =  emon_mach[4]  & mi_write & mi_access;
   assign emon_write[5]     =  emon_match[5]  & mi_write & mi_access;
   assign emon_cfg_write    =  emon_cfg_match  & mi_write & mi_access; 
   assign emon_match        = emon_cfg_match | 
			      (|emon_mon_match[5:0]);
   always @ (posedge clk) 
     if(reset) 
       emon_cfg_reg[DW-1:0]<={(DW){1'b0}}; 
     else if(emon_cfg_write) 
       emon_cfg_reg[DW-1:0] <= mi_data_in[DW-1:0]; 
   assign emon_vector[15:0] = {1'b0, 
			       1'b0,
			       etx_wbfifo_wait,
			       etx_wbfifo_access,
			       etx_wrfifo_wait,
			       etx_wrfifo_access,
			       etx_rdfifo_wait,
			       etx_rdfifo_access,
			       erx_wbfifo_wait,
			       erx_wbfifo_access,
			       erx_wrfifo_wait,
			       erx_wrfifo_access,
			       erx_rdfifo_wait,
			       erx_rdfifo_access,
			       1'b1,
			       1'b0};
   genvar 	     i; 
   generate
      for (i=0;i<MONS;i=i+1) begin : gen_mon 
	 emon_counter emon_counter(
				   .emon_reg		(emon_reg[i]), 
				   .emon_zero_flag	(emon_zero_flag[i]), 
				   .clk		        (clk), 
				   .reset		(reset), 
				   .emon_vector	        (emon_vector[15:0]), 
				   .emon_sel		(emon_cfg_reg[4*i+3:4*i]), 
				   .reg_write		(emon_write[i]), 
				   .reg_data		(mi_data_in[DW-1:0])); 
      end
   endgenerate
   integer j; 
   always @* 
     begin
	emon_reg_mux[DW-1:0]  = {(DW){1'b0}}; 
	for(j=0;j<MONS;j=j+1) 
	  emon_reg_mux[DW-1:0] = emon_reg_mux[DW-1:0] | ({(DW){emon_mon_match[j]}} & emon_reg[j]); 
     end
   always @ (posedge clk) 
     if(emon_read) 
       begin
	  mi_data_out[DW-1:0] <= emon_reg_mux[DW-1:0]; 
	  mi_data_sel         <= emon_match; 
       end
endmodule
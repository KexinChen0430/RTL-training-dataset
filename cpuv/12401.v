module wishbone_mem_interconnect ( 
  input 				      clk, 
  input 				      rst, 
  input 				      i_m_we, 
  input				        i_m_stb, 
  input				        i_m_cyc, 
  input		    [3:0]	  i_m_sel, 
  input		    [31:0]	i_m_adr, 
  input  		  [31:0]	i_m_dat, 
  output reg	[31:0]	o_m_dat, 
  output reg			    o_m_ack, 
  output reg			    o_m_int, 
${PORTS} 
);
${MEM_PARAMS} 
${MEM_SELECT} 
${DATA} 
${ACK} 
${INT} 
${ASSIGN} 
endmodule 
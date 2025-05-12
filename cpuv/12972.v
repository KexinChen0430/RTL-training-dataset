module erx_protocol (
   erx_test_access, erx_test_data, erx_rdwr_access, erx_rr_access,
   erx_packet,
   clk, test_mode, rx_packet, rx_burst, rx_access
   );
   parameter AW   = 32;
   parameter DW   = 32;
   parameter PW   = 104;
   parameter ID   = 12'h800; 
   input           clk;
   input 	   test_mode;
   output 	   erx_test_access;
   output [31:0]   erx_test_data;
   input [PW-1:0]  rx_packet;
   input 	   rx_burst;
   input 	   rx_access;
   output          erx_rdwr_access;
   output          erx_rr_access;
   output [PW-1:0] erx_packet;
   reg [31:0] 	   dstaddr_reg; 
   wire [31:0] 	   dstaddr_next; 
   wire [31:0] 	   dstaddr_mux; 
   reg 		   erx_rdwr_access; 
   reg 		   erx_rr_access; 
   reg [PW-1:0]    erx_packet; 
   wire [11:0] 	   myid; 
   wire [31:0] 	   rx_addr; 
   wire 	   read_response; 
   reg 		   erx_test_access; 
   assign 	 myid[11:0]     = ID;
   assign        rx_addr[31:0]  = rx_packet[39:8];
   always @ (posedge clk)
     if(rx_access)
       dstaddr_reg[31:0]    <= dstaddr_mux[31:0];
   assign dstaddr_next[31:0] = dstaddr_reg[31:0] + 4'b1000;
   assign dstaddr_mux[31:0]  = rx_burst ? dstaddr_next[31:0] : rx_addr[31:0];
   assign read_response = (rx_addr[31:20] == myid[11:0]) &
			  (rx_addr[19:16] == `EGROUP_RR);
   always @ (posedge clk)
     begin
	  erx_rdwr_access     <= ~test_mode & rx_access & ~read_response;
	  erx_rr_access       <= ~test_mode & rx_access & read_response;
	  erx_test_access     <= test_mode  & rx_access & ~read_response;
	  erx_packet[PW-1:0]  <= {rx_packet[PW-1:40],
				  dstaddr_mux[31:0],
				  rx_packet[7:0]
				  };
     end
   assign erx_test_data[31:0] = erx_packet[71:40];
endmodule
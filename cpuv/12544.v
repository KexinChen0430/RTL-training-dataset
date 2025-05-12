module flash_int(reset, clock, op, address, wdata, rdata, busy, flash_data,
		 flash_address, flash_ce_b, flash_oe_b, flash_we_b,
		 flash_reset_b, flash_sts, flash_byte_b);
   parameter access_cycles = 5; 
   parameter reset_assert_cycles = 1000; 
   parameter reset_recovery_cycles = 30; 
   input reset, clock; 
   input [1:0] op; 
   input [22:0] address; 
   input [15:0] wdata; 
   output [15:0] rdata; 
   output busy; 
   inout [15:0] flash_data; 
   output [23:0] flash_address; 
   output flash_ce_b, flash_oe_b, flash_we_b; 
   output flash_reset_b, flash_byte_b; 
   input  flash_sts; 
   reg [1:0] lop; 
   reg [15:0] rdata; 
   reg busy; 
   reg [15:0] flash_wdata; 
   reg flash_ddata; 
   reg [23:0] flash_address; 
   reg flash_oe_b, flash_we_b, flash_reset_b; 
   assign flash_ce_b = flash_oe_b && flash_we_b; 
   assign flash_byte_b = 1; 
   assign flash_data = flash_ddata ? flash_wdata : 16'hZ; 
   initial
     flash_reset_b <= 1'b1; 
   reg [9:0] state; 
   always @(posedge clock) 
     if (reset) 
       begin
			state <= 0; 
			flash_reset_b <= 0; 
			flash_we_b <= 1; 
			flash_oe_b <= 1; 
			flash_ddata <= 0; 
			busy <= 1; 
       end
     else if (flash_reset_b == 0) 
       if (state == reset_assert_cycles) 
			begin
				flash_reset_b <= 1; 
				state <= 1023-reset_recovery_cycles; 
			end
       else
			state <= state+1; 
	 else if ((state == 0) && !busy) 
       begin
			flash_address <= {address, 1'b0}; 
			flash_we_b <= 1; 
			flash_oe_b <= 1; 
			flash_ddata <= 0; 
			flash_wdata <= wdata; 
			lop <= op; 
			if (op != `FLASHOP_IDLE) 
				begin
					busy <= 1; 
					state <= state+1; 
				end
			else
				busy <= 0; 
			end
		else if ((state==0) && flash_sts) 
			busy <= 0; 
		else if (state == 1) 
			begin
				if (lop == `FLASHOP_WRITE) 
					flash_ddata <= 1; 
				else if (lop == `FLASHOP_READ) 
					flash_oe_b <= 0; 
				state <= state+1; 
       end
     else if (state == 2) 
       begin
			if (lop == `FLASHOP_WRITE) 
				flash_we_b <= 0; 
			state <= state+1; 
       end
     else if (state == access_cycles+1) 
       begin
			if (lop == `FLASHOP_WRITE) 
				flash_we_b <= 1; 
			if (lop == `FLASHOP_READ) 
				rdata <= flash_data; 
			state <= 0; 
       end
     else
       begin
			if (!flash_sts) 
				busy <= 1; 
			state <= state+1; 
       end
endmodule
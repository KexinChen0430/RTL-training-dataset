module  stratixgx_rublock 
	(
	clk, 
	shiftnld, 
	captnupdt, 
	regin, 
	rsttimer, 
	rconfig, 
	regout, 
	pgmout 
	);
	parameter operation_mode			= "remote"; 
	parameter sim_init_config			= "factory"; 
	parameter sim_init_watchdog_value	= 0; 
	parameter sim_init_page_select		= 0; 
	parameter sim_init_status			= 0; 
	parameter lpm_type					= "stratixgx_rublock"; 
	input clk; 
	input shiftnld; 
	input captnupdt; 
	input regin; 
	input rsttimer; 
	input rconfig; 
	output regout; 
	output [2:0] pgmout; 
	reg [16:0] update_reg; 
	reg [4:0] status_reg; 
	reg [21:0] shift_reg; 
	reg [2:0] pgmout_update; 
	integer i; 
	initial
	begin
		if (operation_mode == "local") 
			pgmout_update = 1; 
		else 
			pgmout_update = 0; 
		shift_reg = 0; 
		status_reg = sim_init_status; 
		update_reg[16:5] = sim_init_watchdog_value; 
		if (sim_init_watchdog_value > 0) 
			update_reg[4] = 1; 
		else 
			update_reg[4] = 0; 
		update_reg[3:1] = sim_init_page_select; 
		if (sim_init_config == "factory") 
			update_reg[0] = 0; 
		else 
			update_reg[0] = 1; 
		$display("Info: Remote Update Block: Initial configuration:");
		$display ("Time: %0t  Instance: %m", $time);
		$display("        -> Field CRC, POF ID, SW ID Error Caused Reconfiguration is set to %s", status_reg[0] ? "True" : "False");
		$display("        -> Field nSTATUS Caused Reconfiguration is set to %s", status_reg[1] ? "True" : "False");
		$display("        -> Field Core nCONFIG Caused Reconfiguration is set to %s", status_reg[2] ? "True" : "False");
		$display("        -> Field Pin nCONFIG Caused Reconfiguration is set to %s", status_reg[3] ? "True" : "False");
		$display("        -> Field Watchdog Timeout Caused Reconfiguration is set to %s", status_reg[4] ? "True" : "False");
		$display("        -> Field Configuration Mode is set to %s", update_reg[0] ? "Application" : "Factory");
		$display("        -> Field PGM[] Page Select is set to %d", update_reg[3:1]);
		$display("        -> Field User Watchdog is set to %s", update_reg[4] ? "Enabled" : "Disabled");
		$display("        -> Field User Watchdog Timeout Value is set to %d", update_reg[16:5]);
	end
	assign regout = !shift_reg[0]; 
	assign pgmout = pgmout_update; 
	always @(clk) 
	begin
		if (clk == 1) 
		begin
			if (shiftnld == 1) 
			begin
				for (i=0; i<=20; i=i+1) 
				begin
					shift_reg[i] <= shift_reg[i+1]; 
				end
				shift_reg[21] <= regin; 
			end
			else if (shiftnld == 0) 
			begin
				if (captnupdt == 1) 
				begin
					shift_reg <= {update_reg, status_reg}; 
				end
				else if (captnupdt == 0) 
				begin
					if (operation_mode == "remote" && sim_init_config == "factory") 
					begin
						update_reg[16:0] <= shift_reg[21:5]; 
						$display("Info: Remote Update Block: Update Register updated at time %d ps", $time);
						$display ("Time: %0t  Instance: %m", $time);
						$display("        -> Field Configuration Mode is set to %s", shift_reg[5] ? "Application" : "Factory");
						$display("        -> Field PGM[] Page Select is set to %d", shift_reg[8:6]);
						$display("        -> Field User Watchdog is set to %s", (shift_reg[9] == 1) ? "Enabled" : (shift_reg[9] == 0) ? "Disabled" : "x");
						$display("        -> Field User Watchdog Timeout Value is set to %d", shift_reg[21:10]);
					end
					else 
					begin
						$display("Warning: Remote Update Block: Attempted update of Update Register at time %d ps when Configuration is set to Application", $time);
						$display ("Time: %0t  Instance: %m", $time);
					end
				end
				else 
				begin
					shift_reg <= 'bx; 
					if (sim_init_config == "factory") 
					begin
						update_reg[16:1] <= 'bx; 
					end
				end
			end
			else 
			begin
				shift_reg <= 'bx; 
				if (sim_init_config == "factory") 
				begin
					update_reg[16:1] <= 'bx; 
				end
			end
		end
		else if (clk != 0) 
		begin
			shift_reg <= 'bx; 
			if (sim_init_config == "factory") 
			begin
				update_reg[16:1] <= 'bx; 
			end
		end
	end
	always @(rconfig) 
	begin
		if (rconfig == 1) 
		begin
			$display("Info: Remote Update Block: Reconfiguration initiated at time %d ps", $time);
			$display ("Time: %0t  Instance: %m", $time);
			$display("        -> Field Configuration Mode is set to %s", update_reg[0] ? "Application" : "Factory");
			$display("        -> Field PGM[] Page Select is set to %d", update_reg[3:1]);
			$display("        -> Field User Watchdog is set to %s", (update_reg[4] == 1) ? "Enabled" : (update_reg[4] == 0) ? "Disabled" : "x");
			$display("        -> Field User Watchdog Timeout Value is set to %d", update_reg[16:5]);
			if (operation_mode == "remote") 
			begin
				pgmout_update <= update_reg[3:1]; 
			end
			else if (operation_mode == "local") 
			begin
				pgmout_update <= 'b001; 
			end
			else 
			begin
				pgmout_update <= 'bx; 
			end
		end
		else if (rconfig != 0) 
		begin
			pgmout_update <= 'bx; 
		end
	end
endmodule 
module fsmotor # 
(
	parameter integer C_MICROSTEP_WIDTH = 3, 
	parameter integer C_INVERT_DIR = 0 
) (
);
	assign s0_zpd = pm0_zpd; 
	assign s1_zpd = pm1_zpd; 
	assign s4_zpd = rm0_zpd; 
	assign s5_zpd = rm1_zpd; 
	assign pm_ms     = s0_ms; 
	assign pm0_xen   = s0_xen; 
	assign pm0_xrst  = s0_xrst; 
	assign pm0_drive = s0_drive; 
	if (C_INVERT_DIR == 0) begin 
		assign pm0_dir   = s0_dir; 
	end
	else begin 
		assign pm0_dir   = ~s0_dir; 
	end
endmodule 
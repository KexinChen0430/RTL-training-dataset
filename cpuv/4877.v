module brush_motor_driver(
		input					rsi_MRST_reset, 
		input					csi_MCLK_clk, 
		input		[31:0]	avs_ctrl_writedata, 
		output	[31:0]	avs_ctrl_readdata, 
		input		[3:0]		avs_ctrl_byteenable, 
		input		[2:0]		avs_ctrl_address, 
		input					avs_ctrl_write, 
		input					avs_ctrl_read, 
		output				avs_ctrl_waitrequest, 
		input					rsi_PWMRST_reset, 
      input					csi_PWMCLK_clk, 
		output HX, 
		output HY 
		);
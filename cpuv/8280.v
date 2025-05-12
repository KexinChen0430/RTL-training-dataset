module i2c_module(clock, nreset,
		  scl_out, scl_out_en, scl_in,
		  sda_out, sda_out_en, sda_in,
		  write_byte, read_byte, read_mode,
		  ack, drive_ack,
		  do_start, do_stop,
		  finished);
module instantiations */
	 mod_rom		rom_t		(rst, clk, mod0_ie, mod0_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod0_inst, mod0_data);
	 mod_memory_hierarchy	ram_t		(rst, clk, mod1_ie, mod1_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod1_inst, mod1_data, cpu_stall, mod_sram_clk, mod_sram_adv, mod_sram_cre, mod_sram_ce, mod_sram_oe, mod_sram_we, mod_sram_lb, mod_sram_ub, mod_sram_data, mod_sram_addr, mod_vga_sram_data, mod_vga_sram_addr, mod_vga_sram_read, mod_vga_sram_rdy, pmc_cache_miss_I, pmc_cache_miss_D, pmc_cache_access_I, pmc_cache_access_D);
	 mod_uart	uart_t		(rst, clk, mod2_ie, mod2_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod2_inst, mod2_data, mod_uart_txd, mod_uart_rxd, i_uart, pmc_uart_recv, pmc_uart_send);
	 mod_switches 	switches_t 	(rst, clk, mod3_ie, mod3_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod3_inst, mod3_data, mod_switches_switches);
	 mod_leds	leds_t    	(rst, clk, mod4_ie, mod4_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod4_inst, mod4_data, mod_leds_leds);
	 mod_gpio	gpio_t		(rst, clk, mod5_ie, mod5_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod5_inst, mod5_data, mod_gpio_gpio);
	 mod_vga		vga_t		(rst, clk, mod6_ie, mod6_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod6_inst, mod6_data, mod_vga_rgb, mod_vga_hs, mod_vga_vs, mod_vga_sram_data, mod_vga_sram_addr, mod_vga_sram_read, mod_vga_sram_rdy);
	 mod_plpid	plpid_t   	(rst, clk, mod7_ie, mod7_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod7_inst, mod7_data);
	 mod_timer	timer_t	  	(rst, clk, mod8_ie, mod8_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod8_inst, mod8_data, i_timer);
	 mod_sseg	sseg_t		(rst, clk, mod9_ie, mod9_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, mod9_inst, mod9_data, mod_sseg_an, mod_sseg_display);
	mod_interrupt	interrupt_t	(rst, clk, modA_ie, modA_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, modA_inst, modA_data, int, int_ack, i_timer, i_uart, i_button);
	mod_pmc		pmc_t		(rst, clk, modB_ie, modB_de, ieff_addr, deff_addr, cpu_drw, cpu_bus_data, modB_inst, modB_data, int, pmc_cache_miss_I, pmc_cache_miss_D, pmc_cache_access_I, pmc_cache_access_D, pmc_uart_recv, pmc_uart_send);
endmodule
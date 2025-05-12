module
    if (interrupts > 0) begin
		  o_wbs_int	    <= 1;
    end
    else begin
		  o_wbs_int	    <= 0;
    end
	  prev_gpio_in	  <= gpio_in;
	end
end
endmodule
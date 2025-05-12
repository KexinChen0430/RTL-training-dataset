module reset to finish
    #100 reset = 0;
	end
  always begin
    #10 clock = !clock;
  end
endmodule
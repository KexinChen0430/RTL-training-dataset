module to draw notes from.
	always @ (posedge slowCLK) begin
		if (START) begin
			DONE <= 0;
			counter <= counter + 1;
			case (MODE)
				NORMAL  : begin if (counter <= DURATION/128*125) EN <= 1; else EN <= 0; end
				STACCATO: begin if (counter <= DURATION/128*102) EN <= 1; else EN <= 0; end
				SLURRED : begin if (counter <= DURATION)         EN <= 1; end
			endcase
			if (counter == DURATION) begin
				counter <= 0;
				DONE <= 1;
			end
		end
	end
endmodule
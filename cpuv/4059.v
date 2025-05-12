module idles until
the following tile compute its outputs based on the data in the aforementioned
RAM.
*/
always@(posedge clk) begin
	if(rstIn) begin
		enable 			<= 0;
		transfer 		<= 0;
		iterationCnt 	<= 0;
		loopCnt 			<= 0;
		tileIdle 		<= 0;
		ramWait 			<= 0;
		rstNodes 		<= 1;
		CURRENT_STATE <= READY;
	end
	else begin
		rstNodes <= 0;
		case(CURRENT_STATE)
			READY: begin
				tileIdle <= 1;
				if(dataAvailable) begin
					tileIdle <= 0;
					dataRead <= 1;
					CURRENT_STATE <= PROCESS;
				end
			end
			PROCESS: begin
				iterationCnt <= iterationCnt + 1'd1;
				if(iterationCnt == PRV_SIZE*PRV_LOOP - 1)
					dataRead <= 0;
				if(iterationCnt < PRV_SIZE*PRV_LOOP)
					enable <= 1;
				else begin
					enable 	<= 0;
					iterationCnt <= 0;
					loopCnt <= loopCnt + 1'b1;
					transfer 	<= 1;
					CURRENT_STATE <= TRANSFER;
				end
			end
			TRANSFER: begin
				iterationCnt <= iterationCnt + 1'b1;
				if(iterationCnt == SIZE - 1'b1) begin
					iterationCnt <= 0;
					transfer 	<= 0;
					rstNodes 	<= 1;
					if(loopCnt < LOOP) begin
						dataRead <= 1;
						CURRENT_STATE <= PROCESS;
					end
					else begin
						CURRENT_STATE <= WAIT;
						loopCnt <= 0;
					end
				end
			end
			WAIT: begin
				ramWait <= 1;
				if(!ramFull && ramWait) begin
					ramWait <= 0;
					tileIdle <= 1;
					CURRENT_STATE <= READY;
				end
			end
		endcase
	end
end
endmodule
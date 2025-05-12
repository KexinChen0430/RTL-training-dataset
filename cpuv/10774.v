module uart_tx( 
	input clk, 
	input rst, 
	input send, 
	input [7:0] data_tx, 
	output done, 
	output txd 
);
reg [9:0] bitTmr; 
reg [3:0] bitIndex; 
wire txBit; 
reg [1:0] txState; 
assign done = (txState == `STOP) ? 1'b1 : 1'b0; 
assign txd = (txState == `SEND_BIT) ? txBit : 1'b1; 
assign txBit =(         (bitIndex == 0) ? 1'b0 :
               (        (bitIndex == 1) ? data_tx[0] :
                (       (bitIndex == 2) ? data_tx[1] :
                 (      (bitIndex == 3) ? data_tx[2] :
                  (     (bitIndex == 4) ? data_tx[3] :
                   (    (bitIndex == 5) ? data_tx[4] :
                    (   (bitIndex == 6) ? data_tx[5] :
                     (  (bitIndex == 7) ? data_tx[6] :
                      ( (bitIndex == 8) ? data_tx[7] :
                                          1'b1
                      )
                     )
                    )
                   )
                  )
                 )
                )
               )
              );
always@(posedge clk) begin 
	if(rst) 
		txState<= `RDY; 
	else
		case(txState) 
			`RDY : 
                begin
                    bitIndex <= 0; 
                    bitTmr   <= 0; 
					if(send == 1'b1) 
						txState<=`SEND_BIT; 
					else
						txState<=`RDY; 
			    end
			`SEND_BIT : begin 
					if (bitTmr == `BIT_TMR_MAX-1) 
                        begin
                            bitTmr <=0; 
                            if (bitIndex == `BIT_INDEX_MAX-1) 
                                begin
                                    txState<=`STOP; 
                                end
                            else
                                begin
                                    bitIndex <= bitIndex + 1'b1; 
                                    txState<=`SEND_BIT; 
                                end
                        end
					else
                        begin
                            bitTmr <= bitTmr + 1'b1; 
    						txState <= `SEND_BIT; 
                        end
			end
            `STOP : 
                begin
                    if(send == 1'b1) 
                        txState<=txState; 
                    else 
                        txState<=`RDY; 
                end
			default : txState <= `RDY; 
		endcase
end
endmodule
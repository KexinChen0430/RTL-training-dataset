module lcd (
	input            clk,              
	output reg       lcd_rs,           
	output reg       lcd_rw,           
	output reg       lcd_e,            
	output reg [7:4] lcd_d,            
	output     [4:0] mem_addr,         
	input      [7:0] mem_bus           
	);
	parameter        n = 24;           
	parameter        j = 17;           
	parameter        k = 11;           
	parameter        noop = 6'b010000; 
	reg        [n:0] count = 0;        
	reg        [5:0] lcd_state = noop; 
	reg              init = 1;         
	reg              row = 0;          
	assign mem_addr = {row, count[k+6:k+3]}; 
	initial count[j+7:j+2] = 11;       
	always @ (posedge clk) begin       
		count <= count + 1;             
		if (init) begin                 
			case (count[j+7:j+2])       
				1: lcd_state <= 6'b000010;    
				2: lcd_state <= 6'b000010;
				3: lcd_state <= 6'b001000;
				4: lcd_state <= 6'b000000;    
				5: lcd_state <= 6'b001100;
				6: lcd_state <= 6'b000000;    
				7: lcd_state <= 6'b000001;
				8: lcd_state <= 6'b000000;    
				9: lcd_state <= 6'b000110;
				10: begin init <= ~init; count <= 0; end 
			endcase
			{lcd_e,lcd_rs,lcd_rw,lcd_d[7:4]} <= {^count[j+1:j+0] & ~lcd_rw,lcd_state};
		end else begin                  
			case (count[k+7:k+2])       
				32: lcd_state <= {3'b001,~row,2'b00};                                 
				33: lcd_state <= 6'b000000;
				34: begin count <= 0; row <= ~row; end                                
				default: lcd_state <= {2'b10, ~count[k+2] ? mem_bus[7:4] : mem_bus[3:0]}; 
			endcase
			{lcd_e,lcd_rs,lcd_rw,lcd_d[7:4]} <= {^count[k+1:k+0] & ~lcd_rw,lcd_state};
		end
	end
endmodule
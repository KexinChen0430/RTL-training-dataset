module de3d_tc_load_gen
	#(parameter BYTES = 4) 
	(
	input             de_clk, 
	input     [20:0]  tex_org, 
	input     [11:0]  tptch, 
	input     [3:0]   tc_op_store, 
	input     [8:0]   ul_store_x, 
	input     [8:0]   ul_store_y, 
	input     [8:0]   ll_store_x, 
	input     [8:0]   ll_store_y, 
	input     [8:0]   ur_store_x, 
	input     [8:0]   ur_store_y, 
	input     [8:0]   lr_store_x, 
	input     [8:0]   lr_store_y, 
	input     [2:0]   bpt, 
	input     [1:0]   req_count, 
	output reg	[31:0]	tex_address 
	);
reg     [6:0]   tex_x1_r; 
reg     [6:0]   tex_x2_r; 
reg	[31:0]	p_mult; 
reg	[31:0]	int_add; 
reg     [1:0]   req_current; 
always @* begin
		case (bpt) 
			3: 
				begin
					tex_x1_r = {2'b0,ul_store_x[8:5], 1'b0};
					tex_x2_r = {2'b0,lr_store_x[8:5], 1'b0};
				end
			5: 
				begin
					tex_x1_r = {ul_store_x[8:3], 1'b0};
					tex_x2_r = {lr_store_x[8:3], 1'b0};
				end
			default: 
				begin
					tex_x1_r = {1'b0,ul_store_x[8:4], 1'b0};
					tex_x2_r = {1'b0,lr_store_x[8:4], 1'b0};
				end
            	endcase
      	end
always @* begin
                casex({tc_op_store, req_count}) 
                        6'b1000_xx: req_current = 2'b00; 
                        6'b0100_xx: req_current = 2'b01; 
                        6'b0010_xx: req_current = 2'b10; 
                        6'b0001_xx: req_current = 2'b11; 
                        6'b0011_01: req_current = 2'b10; 
                        6'b0011_00: req_current = 2'b11; 
                        6'b0101_01: req_current = 2'b01; 
                        6'b0101_00: req_current = 2'b11; 
                        6'b0110_01: req_current = 2'b01; 
                        6'b0110_00: req_current = 2'b10; 
                        6'b1001_01: req_current = 2'b00; 
                        6'b1001_00: req_current = 2'b11; 
                        6'b1010_01: req_current = 2'b00; 
                        6'b1010_00: req_current = 2'b10; 
                        6'b1100_01: req_current = 2'b00; 
                        6'b1100_00: req_current = 2'b01; 
                        6'b0111_10: req_current = 2'b01; 
                        6'b0111_01: req_current = 2'b10; 
                        6'b0111_00: req_current = 2'b11; 
                        6'b1011_10: req_current = 2'b00; 
                        6'b1011_01: req_current = 2'b10; 
                        6'b1011_00: req_current = 2'b11; 
                        6'b1101_10: req_current = 2'b00; 
                        6'b1101_01: req_current = 2'b01; 
                        6'b1101_00: req_current = 2'b11; 
                        6'b1110_10: req_current = 2'b00; 
                        6'b1110_01: req_current = 2'b01; 
                        6'b1110_00: req_current = 2'b10; 
                        6'b1111_11: req_current = 2'b00; 
                        6'b1111_10: req_current = 2'b01; 
                        6'b1111_01: req_current = 2'b10; 
                        6'b1111_00: req_current = 2'b11; 
                        default:    req_current = 2'b00; 
                endcase
        end
always @ (posedge de_clk) begin
    	case(req_current)
	2'b00: begin
			p_mult <= (ul_store_y * {{4{tptch[11]}}, tptch});	
			`ifdef BYTE16 int_add <= (tex_org + {25'h0, tex_x1_r}); `endif
			`ifdef BYTE8  int_add <= ({tex_org, 1'b0} + {{14{tex_x1_r[13]}}, tex_x1_r}); `endif
			`ifdef BYTE4  int_add <= ({tex_org, 2'b0} + {{14{tex_x1_r[13]}}, tex_x1_r}); `endif
		end
	2'b01:	 begin
			p_mult <= (ll_store_y * {{4{tptch[11]}}, tptch});	
			`ifdef BYTE16 int_add <= (tex_org + {25'h0, tex_x1_r}); `endif
			`ifdef BYTE8  int_add <= ({tex_org, 1'b0} + {{14{tex_x1_r[13]}}, tex_x1_r}); `endif
			`ifdef BYTE4  int_add <= ({tex_org, 2'b0} + {{14{tex_x1_r[13]}}, tex_x1_r}); `endif
		 end
	2'b10:    begin
			p_mult <= (ur_store_y * {{4{tptch[11]}}, tptch});	
			`ifdef BYTE16 int_add <= (tex_org + {25'h0, tex_x2_r}); `endif
			`ifdef BYTE8  int_add <= ({tex_org, 1'b0} + {{14{tex_x2_r[13]}}, tex_x2_r}); `endif
			`ifdef BYTE4  int_add <= ({tex_org, 2'b0} + {{14{tex_x2_r[13]}}, tex_x2_r}); `endif
		 end
	2'b11:   begin
			p_mult <= (lr_store_y * {{4{tptch[11]}}, tptch});	
			`ifdef BYTE16 int_add <= (tex_org + {25'h0, tex_x2_r}); `endif
			`ifdef BYTE8  int_add <= ({tex_org, 1'b0} + {{14{tex_x2_r[13]}}, tex_x2_r}); `endif
			`ifdef BYTE4  int_add <= ({tex_org, 2'b0} + {{14{tex_x2_r[13]}}, tex_x2_r}); `endif
		end
    	endcase
  end
always @* begin
    	if (BYTES == 16)     tex_address = p_mult + int_add;
    	else if (BYTES == 8) tex_address = {p_mult, 1'b0} + int_add;
    	else                 tex_address = {p_mult, 2'b0} + int_add;
    end
endmodule
module data_mem (data_out,data_in,mem_ctrl_addr,clk,dm_ctrl_sig); 
	output [0:127] data_out; 
	input [0:127] data_in; 
	input [0:31] mem_ctrl_addr; 
	input clk; 
	input [0:1] dm_ctrl_sig; 
	reg [0:127] data_out; 
	reg [127:0] data_mem [255:0]; 
	initial
	begin
		$readmemh("rf1.fill",data_mem); 
	end
	always @(posedge clk)
	begin
		case(dm_ctrl_sig)
			`memwld: 
				begin
					data_out<=data_mem[mem_ctrl_addr[0:7]]; 
				end
			`memwst: 
				begin
					data_mem[mem_ctrl_addr[0:7]]<=data_in; 
					$display("Value written to data mem",data_mem[mem_ctrl_addr[0:7]],"#"); 
				end
			`memnop: 
				begin
					data_out<=128'd0; 
				end
			default: 
				begin
					data_out<=128'd0; 
				end
		endcase 
	end 
endmodule 
module select_logic 
  (
   input wire [1:0] 		sel, 
   input wire [4*`INSN_LEN-1:0] idata, 
   output reg [`INSN_LEN-1:0] 	inst1, 
   output reg [`INSN_LEN-1:0] 	inst2, 
   output wire 			invalid 
   );
   assign invalid = (sel[0] == 1'b1); 
   always @ (*) begin 
      inst1 = `INSN_LEN'h0; 
      inst2 = `INSN_LEN'h0; 
      case(sel) 
	2'b00 : begin 
	   inst1 = idata[31:0]; 
	   inst2 = idata[63:32]; 
	end
	2'b01 : begin 
	   inst1 = idata[63:32]; 
	   inst2 = idata[95:64]; 
	end
	2'b10 : begin 
	   inst1 = idata[95:64]; 
	   inst2 = idata[127:96]; 
	end
	2'b11 : begin 
	   inst1 = idata[127:96]; 
	   inst2 = idata[31:0]; 
	end
      endcase 
   end 
endmodule 
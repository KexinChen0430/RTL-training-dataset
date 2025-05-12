module mux_4x1( 
   input [1:0] sel, 
   input [2*`DATA_LEN-1:0] dat0, 
   input [2*`DATA_LEN-1:0] dat1, 
   input [2*`DATA_LEN-1:0] dat2, 
   input [2*`DATA_LEN-1:0] dat3, 
   output reg [2*`DATA_LEN-1:0] out 
   );
   always @(*) begin 
      case(sel) 
	0: begin 
	   out = dat0; 
	end
	1: begin 
	   out = dat1; 
	end
	2: begin 
	   out = dat2; 
	end
	3: begin 
	   out = dat3; 
	end
      endcase 
   end 
endmodule 
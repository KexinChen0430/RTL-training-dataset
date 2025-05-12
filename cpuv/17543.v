module SPIslave(nCS, CLK, MOSI, MISO); 
   input nCS; 
   input CLK; 
   input MOSI; 
   output MISO; 
   reg [7:0] inbyte; 
   wire [7:0] outbyte; 
   wire       out_valid; 
   reg [7:0]  mem[0:65535]; 
   reg [3:0]  state; 
   reg [15:0] adr; 
   SPIfrontend front(nCS, CLK, MOSI, MISO, inbyte, outbyte, out_valid); 
   always @(posedge nCS) begin 
      state<=0; 
   end
   always @(posedge out_valid) if (!nCS) begin 
      $display("Received %d", outbyte); 
      case (state) 
	0: begin 
	   adr[7:0]<=outbyte; state<=1; 
	end
	1: begin 
	   adr[15:8]<=outbyte; state<=2; 
	end
	2: begin 
	   if (outbyte) begin 
	      state<=3; 
	   end else begin 
	      $display("Reading location 0x%x, which contains 0x%x", adr, mem[adr]); 
	      inbyte<=mem[adr]; 
	      state<=4; 
	   end
	end
	3: begin 
	   mem[adr]<=outbyte; 
	   $display("Writing location 0x%x with 0x%x", adr, outbyte); 
	   state<=0; 
	end
	4: begin 
	   state<=0; 
	end
      endcase 
   end
endmodule 
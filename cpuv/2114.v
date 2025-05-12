module branchhistorytable(clk,pcsrcd,pcd,pcbranchd,originalpc,pcnext,clrbp);
        input             clk;
	input      [1:0]  pcsrcd;
	input      [31:0] originalpc, pcbranchd, pcd;
	output reg [31:0] pcnext;
	output reg        clrbp;
	reg [65:0] branchtargetbuffer[127:0];
	reg [31:0] pcstorage;
	integer i;
	reg foundflag;
  	initial begin
		for (i=0; i<128; i=i+1) begin
        	        branchtargetbuffer[i] = 66'b0;
		end
  	end
	integer j=0;
	integer count=0;
	integer recorder;
	always @(*) begin
		foundflag = 1'b0;
		for (i=0; i<128; i=i+1) begin
			if (originalpc==branchtargetbuffer[i][65:34] ) begin
				if (!branchtargetbuffer[i][1]) begin
				  pcstorage = originalpc;
				  pcnext = branchtargetbuffer[i][33:2];
				end
				foundflag = 1'b1;
				recorder = i;
			end
		end
		if (foundflag) begin
			if (pcsrcd[0]) begin
				clrbp = 1'b0;
				case(branchtargetbuffer[recorder][1:0])
      					2'b00: branchtargetbuffer[recorder][1:0] = 2'b00;
      					2'b01: branchtargetbuffer[recorder][1:0] = 2'b00;
      					2'b10: branchtargetbuffer[recorder][1:0] = 2'b01;
      					2'b11: branchtargetbuffer[recorder][1:0] = 2'b10;
    				endcase
			end
			else begin
				clrbp = 1'b1;
				pcnext = pcstorage;
				case(branchtargetbuffer[recorder][1:0])
      					2'b00: branchtargetbuffer[recorder][1:0] = 2'b01;
      					2'b01: branchtargetbuffer[recorder][1:0] = 2'b10;
      					2'b10: branchtargetbuffer[recorder][1:0] = 2'b11;
      					2'b11: branchtargetbuffer[recorder][1:0] = 2'b11;
    				endcase
			end
		end
		else begin
			if (pcsrcd[0]) begin
				branchtargetbuffer[count][1:0]   = 2'b00;
				branchtargetbuffer[count][33:2]  = pcbranchd;
				branchtargetbuffer[count][65:34] = pcd;
				pcnext = pcbranchd;
				clrbp = 1'b0;
				count = count + 1;
				if (count > 127)
					count = 0;
			end
			else begin
				clrbp = 1'b0;
				pcnext = originalpc;
			end
		end
	end
endmodule
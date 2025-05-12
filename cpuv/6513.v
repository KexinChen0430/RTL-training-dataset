module test(I1,I2,I3,I4,enter,win,lose,reset,equal,bigger,smaller,nums);
	input I1, I2, I3, I4, enter,reset; 
	reg[0:6] a1,a2,a3,a4,suc,b1,b2,b3,b4; 
	reg[0:3] numa,numb; 
	output reg win,lose; 
	output reg equal,bigger,smaller; 
	reg runa,runb; 
	reg [0:3] turn; 
	output reg [0:3] nums; 
	initial begin 
		nums = 0;
		win = 0;
		suc = 0;
		runa = 1;
		runb = 0;
		lose = 0;
		equal = 0;
		bigger = 0;
		smaller = 0;
		a1 = 0;
		a2 = 0;
		a3 = 0;
		a4 = 0;
		b1 = 0;
		b2 = 0;
		b3 = 0;
		b4 = 0;
		numa = 0;
		numb = 0;
		turn = 0;
	end
	always @(posedge I1 or posedge I2 or posedge I3 or posedge I4 or posedge enter or posedge reset) begin 
		if(I1) begin 
		nums = 0;
		nums[0] = 1;
			if(runa) begin 
				a1[numa] = 1; 
				numa = numa + 1; 
			end
			if(runb) begin 
				b1[numb] = 1; 
				numb=numb + 1; 
			end
		end
		else if(I2) begin 
		nums = 0;
		nums[1] = 1;
			if(runa) begin 
				a2[numa] = 1; 
				numa=numa+1; 
			end
			if(runb) begin 
				b2[numb] = 1; 
				numb=numb+1; 
			end
		end
		else if(I3) begin 
		nums = 0;
		nums[2] = 1;
			if(runa) begin 
				a3[numa] = 1; 
				numa=numa+1; 
			end
			if(runb) begin 
				b3[numb] = 1; 
				numb=numb+1; 
			end
		end
		else if(I4) begin 
		nums = 0;
		nums[3] = 1;
			if(runa) begin 
				a4[numa] = 1; 
				numa=numa+1; 
			end
			if(runb) begin 
				b4[numb] = 1; 
				numb=numb+1; 
			end
		end
		else if(enter) begin 
			if(numa >=4) begin 
				runa = 0; 
				runb = 1; 
			end
			else if(numa < 4) begin 
			  a1 = 0; 
			  a2 = 0; 
			  a3 = 0; 
			  a4 = 0; 
			  numa = 0; 
			end
			if(numb >=4) begin 
				suc = (a1~^b1)&(a2~^b2)&(a3~^b3)&(a4~^b4); 
				win = suc[0]&suc[1]&suc[2]&suc[3]&suc[4]&suc[5]&suc[6]; 
				if(!win && turn <3) begin 
					turn=turn+1; 
					b1=0; 
					b2=0; 
					b3=0; 
					b4=0; 
				end
				if(numb > numa) begin 
					smaller = 1; 
					bigger = 0; 
					equal = 0; 
				end
				if(numb == numa) begin 
					smaller = 0; 
					bigger = 0; 
					equal = 1; 
				end
				if(numb < numa) begin 
					smaller = 0; 
					bigger = 1; 
					equal = 0; 
				end
			  numb = 0; 
			end
			if(!win && turn >= 3) 
				lose = 1; 
		end
		else if(reset) begin 
			win = 0; 
			suc = 0; 
			runa = 1; 
			runb = 0; 
			lose = 0; 
			equal = 0; 
			bigger = 0; 
			smaller = 0; 
			nums = 0; 
			a1 = 0; 
			a2 = 0; 
			a3 = 0; 
			a4 = 0; 
			b1 = 0; 
			b2 = 0; 
			b3 = 0; 
			b4 = 0; 
			numa = 0; 
			numb = 0; 
			turn = 0; 
		end
		else begin 
			if(numa == 7) begin 
				runa = 0; 
				runb = 1; 
			end
			if(numb == 7) 
				runb = 0; 
		end
	end
endmodule
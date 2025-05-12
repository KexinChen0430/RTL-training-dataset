module decoder (cx,d);
	output [6:0] d;
	input [10:0] cx;
	reg [6:0] d;
	reg [6:0] s;
	reg [10:0] cx1;
	parameter s0 = 7'b1000;
	parameter s1 = 7'b0100;
	parameter s2 = 7'b0010;
	parameter s3 = 7'b0001;
	parameter s4 = 7'b0111;
	parameter s5 = 7'b0101;
	parameter s6 = 7'b0010;
	parameter s7 = 7'b1001;
	parameter s8 = 7'b0010;
	parameter s9 = 7'b0111;
	parameter s10 = 7'b0101;
	always @(cx)
	begin
		cx1[0] = cx[0];
		cx1[1] = cx[1];
		cx1[2] = cx[2];
		cx1[3] = cx[3];
		cx1[4] = cx[4];
		cx1[5] = cx[5];
		cx1[6] = cx[6];
		cx1[7] = cx[7];
		cx1[8] = cx[8];
		cx1[9] = cx[9];
		cx1[10] = cx[10];
		s[0]= cx[0]+ cx[7];
		s[1]= cx[1]+ cx[4]+ cx[5]+ cx[9]+ cx[10];
		s[2]= cx[2]+ cx[4]+ cx[6]+ cx[8]+ cx[9];
		s[3]= cx[3]+ cx[4]+ cx[5]+ cx[7]+ cx[9]+ cx[10];
		case(s)
			s0:
				begin
					if(cx[0]==1'b0)
					begin
						cx1[0]=1'b1;
					end
					else
					begin
						cx1[0]=1'b0;
					end
				end
			s1:
				begin
					if(cx[1]==1'b0)
					begin
						cx1[1]=1'b1;
					end
					else
					begin
						cx1[1]=1'b0;
					end
				end
			default:
				begin
					cx1[0]=cx[0];
					cx1[1]=cx[1];
					cx1[2]=cx[2];
					cx1[3]=cx[3];
					cx1[4]=cx[4];
					cx1[5]=cx[5];
					cx1[6]=cx[6];
					cx1[7]=cx[7];
					cx1[8]=cx[8];
					cx1[9]=cx[9];
					cx1[10]=cx[10];
				end
		endcase
		d[0] = cx1[4];
		d[1] = cx1[5];
		d[2] = cx1[6];
		d[3] = cx1[7];
		d[4] = cx1[8];
		d[5] = cx1[9];
		d[6] = cx1[10];
	end
endmodule
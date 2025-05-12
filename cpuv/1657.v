module
	always @(posedge clk_vga) begin
		if(mapX == 3 && mapY == 5)
			mColor[7:0] <= startCastle[7:0];
		else if(mapX == 3 && mapY == 6)
			mColor[7:0] <= hallwayTop[7:0];
		else if(mapX == 4 && mapY == 6)
			mColor[7:0] <= hallwayRight[7:0];
		else if(mapX == 4 && mapY == 7)
			mColor[7:0] <= blackKeyRoom[7:0];
		else if(mapX == 2 && mapY == 6)
			mColor[7:0] <= hallwayLeft;
		else if(mapX == 1 && mapY == 6)
			mColor[7:0] <= sCenterMaze;
		else if(mapX == 2 && mapY == 4)
			mColor[7:0] <= swMaze;
		else if(mapX == 2 && mapY == 5)
			mColor[7:0] <= eCenterMaze;
		else if(mapX == 1 && mapY == 5)
			mColor[7:0] <= centerMaze;
		else if(mapX == 1 && mapY == 4)
			mColor[7:0] <= nCenterMaze;
		else if(mapX == 1 && mapY == 3)
			mColor[7:0] <= castle;
		else if(mapX == 1 && mapY == 2)
			mColor[7:0] <= startCastle;
		else begin
			mColor[7:0] <= 8'b00000000;
		end
	end
	assign mapData[7:0] = mColor[7:0];
endmodule
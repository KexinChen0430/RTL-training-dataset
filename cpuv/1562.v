module sevenseg(seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7, score_p1, score_p2, winner);
	input [3:0] score_p1, score_p2; 
	input [1:0] winner; 
	output [6:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7; 
	reg [6:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7; 
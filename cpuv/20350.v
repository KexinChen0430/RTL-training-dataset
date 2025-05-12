module crtaddsl
  (
   hactive_regist,
   hblank_regist,
   hfporch_regist,
   hswidth_regist,
   vactive_regist,
   vblank_regist,
   vfporch_regist,
   vswidth_regist,
   htotal_add,
   hendsync_add,
   endequal_add,
   halfline_add,
   endequalsec_add,
   serrlongfp_substr,
   serr_substr,
   serrsec_substr,
   vendsync_add,
   vendequal_add,
   vtotal_add,
   hfpbhs
   );
  input [13:0]  hactive_regist,
		hblank_regist,
		hfporch_regist,
		hswidth_regist;
  input [11:0] 	vactive_regist,
		vblank_regist,
		vfporch_regist,
		vswidth_regist;
  output [13:0] htotal_add,
		hendsync_add,
		endequal_add,
		halfline_add,
		endequalsec_add,
		serrlongfp_substr,
		serr_substr,
		serrsec_substr;
  output [11:0] vendsync_add,
		vendequal_add,
		vtotal_add;
  output        hfpbhs;
  wire [13:0] 	serrshortfp_substr;
  assign 	vtotal_add[11:0] = vblank_regist[11:0] + vactive_regist[11:0];
  assign 	vendsync_add[11:0] = vfporch_regist[11:0] +
		vswidth_regist[11:0];
  assign 	vendequal_add[11:0] = vfporch_regist[11:0] +
		{vswidth_regist[10:0],1'b0};
  assign 	hfpbhs = (hfporch_regist[13:0] > hswidth_regist[13:0]);
endmodule
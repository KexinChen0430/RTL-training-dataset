module jace(
   input wire clkm,
	input wire clk,
	output wire cpuclk,
	input wire [15:0] a,  
	input wire d3,
	output wire [5:0] dout,   
	input wire wr,
	input wire vramdec,
	output wire intr,
	output wire cpuwait,    
	input wire en254r,
	input wire en254w,
	output wire sramce,     
	output wire cramce,     
	output wire scramoe,    
	output wire scramwr,    
	input wire [7:0] DinShiftR,  
	input wire videoinverso,      
	output wire [9:0] ASRAMVideo,  
	output wire [2:0] ACRAMVideo,  
	input wire [4:0] kbd,
	input wire ear,
	output wire mic,
	output wire spk,
	output wire sync,
	output wire video       
	);
	wire [17:0] c;
	assign cpuclk = c[0];
	master_cnt cont (clk, c);
	gensync gsync (c[5],c[6],c[7],c[8],c[12],c[13],c[14],c[15],c[16],intr,sync);
	io modulo_io (
		.clk(clkm),
		.en254r(en254r),
		.en254w(en254w),
		.kbd(kbd),
		.ear(ear),
		.d3(d3),
		.dout(dout),
		.mic(mic),
		.spk(spk)
	);
   videogen_and_cpuctrl arbitrador(
		.clk(clk),
		.a(a),  
		.wr(wr),
		.vramdec(vramdec),     
		.cnt(c),  
		.DinShiftR(DinShiftR),  
		.videoinverso(videoinverso),      
		.cpuwait(cpuwait),    
		.ASRAMVideo(ASRAMVideo),  
		.ACRAMVideo(ACRAMVideo),  
		.sramce(sramce),     
		.cramce(cramce),     
		.scramoe(scramoe),    
		.scramwr(scramwr),    
		.video(video)       
		);
endmodule
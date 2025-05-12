module alu (
	input  wire [`WordDataBus] in_0,  
	input  wire [`WordDataBus] in_1,  
	input  wire [`AluOpBus]	   op,	  
	output reg	[`WordDataBus] out,	  
	output reg				   of	  
);
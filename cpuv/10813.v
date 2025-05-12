module dzcpu_ucode_cblut
(
	input  wire[7:0]  iMop,          
	output reg [8:0]  oUopFlowIdx    
);
always @ ( iMop )
begin
	case ( iMop )                   
		8'h7C: oUopFlowIdx = 9'd16;		  
		8'h11: oUopFlowIdx = 9'd69;		  
		8'h38: oUopFlowIdx = 9'd505;		
		`RRr_a,`RRr_b, `RRr_c, `RRr_d, `RRr_e, `RRr_h,	`RRr_l: oUopFlowIdx = 9'd509;		
	default:                             
			oUopFlowIdx = 9'd0;           
	endcase                              
end                                     
endmodule                               
module paula_floppy_fifo
(
	input 	clk,		    	
  input clk7_en,           
	input 	reset,			   	
	input	[15:0] in,			
	output	reg [15:0] out,	
	input	rd,					
	input	wr,					
	output	reg empty,			
	output	full,				
	output	[11:0] cnt       
);
reg 	[15:0] mem [2047:0];	
reg		[11:0] in_ptr;			
reg		[11:0] out_ptr;		
wire	equal;					
assign cnt = in_ptr - out_ptr; 
always @(posedge clk) begin
  if (clk7_en) begin
  	if (wr)
  		mem[in_ptr[10:0]] <= in; 
  end
end
always @(posedge clk) begin
  if (clk7_en) begin
  	out=mem[out_ptr[10:0]]; 
  end
end
always @(posedge clk) begin
  if (clk7_en) begin
  	if (reset)
  		in_ptr[11:0] <= 0; 
  	else if(wr)
  		in_ptr[11:0] <= in_ptr[11:0] + 12'd1; 
  end
end
always @(posedge clk) begin
  if (clk7_en) begin
  	if (reset)
  		out_ptr[11:0] <= 0; 
  	else if (rd)
  		out_ptr[11:0] <= out_ptr[11:0] + 12'd1; 
  end
end
assign equal = (in_ptr[10:0]==out_ptr[10:0]) ? 1'b1 : 1'b0; 
always @(posedge clk) begin
  if (clk7_en) begin
  	if (equal && (in_ptr[11]==out_ptr[11]))
  		empty <= 1'b1; 
  	else
  		empty <= 1'b0; 
  end
end
assign full = (equal && (in_ptr[11]!=out_ptr[11])) ? 1'b1 : 1'b0; 
endmodule
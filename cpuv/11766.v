module reg_1r1w
   #(
     parameter WIDTH=32,    
     parameter ADRWID=10,   
     parameter DEPTH=1024,  
     parameter RST=0        
     )
    (
   data_out,               
   data_in, ra, wa, wr, rd, clk, rst_l 
   );
    input [WIDTH-1:0] data_in;   
    input [ADRWID-1:0] ra;       
    input [ADRWID-1:0] wa;       
    input wr;                    
    input rd;                    
    input clk;                   
    input rst_l;                 
    output [WIDTH-1:0] data_out; 
    reg [WIDTH-1:0] array [DEPTH-1:0]; 
    reg [ADRWID-1:0] ra_r, wa_r;      
    reg [WIDTH-1:0]  data_in_r;       
    reg             wr_r;             
    reg             rd_r;             
    integer        x;
    always @(posedge clk) begin
       int tmp = x + 1;               
       if (tmp !== x + 1) $stop;      
    end
    always @(posedge clk or negedge rst_l) begin
       if (!rst_l) begin              
	  for (x=0; x<DEPTH; x=x+1) begin 
             if (RST == 1) begin
		array[x] <= 0;             
             end
	  end
	  ra_r <= 0;
	  wa_r <= 0;
	  wr_r <= 0;
	  rd_r <= 0;
	  data_in_r <= 0;
       end
       else begin                     
	  ra_r <= ra;
	  wa_r <= wa;
	  wr_r <= wr;
	  rd_r <= rd;
	  data_in_r <= data_in;
	  if (wr_r) array[wa_r] <= data_in_r;
       end
    end
endmodule
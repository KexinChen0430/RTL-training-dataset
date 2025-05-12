module fifo_empty_block (
   rd_fifo_empty,       
   rd_addr,             
   rd_gray_pointer,     
   reset,               
   rd_clk,              
   rd_wr_gray_pointer,  
   rd_read              
   );
   parameter AW = 2; 
   input           reset;              
   input           rd_clk;             
   input [AW:0]    rd_wr_gray_pointer; 
   input           rd_read;            
   output          rd_fifo_empty;      
   output [AW-1:0] rd_addr;            
   output [AW:0]   rd_gray_pointer;    
   reg [AW:0]      rd_gray_pointer;    
   reg [AW:0]      rd_binary_pointer;  
   reg             rd_fifo_empty;      
   wire            rd_fifo_empty_next; 
   wire [AW:0]     rd_binary_next;     
   wire [AW:0]     rd_gray_next;       
   always @(posedge rd_clk or posedge reset)
     if (reset) begin
       rd_binary_pointer <= {(AW+1){1'b0}};
       rd_gray_pointer   <= {(AW+1){1'b0}};
     end else if (rd_read) begin
       rd_binary_pointer <= rd_binary_next;
       rd_gray_pointer   <= rd_gray_next;
     end
   assign rd_addr = rd_binary_pointer[AW-1:0];
   assign rd_binary_next = rd_binary_pointer + {{(AW){1'b0}}, rd_read};
   assign rd_gray_next = {1'b0, rd_binary_next[AW:1]} ^ rd_binary_next;
   assign rd_fifo_empty_next = (rd_gray_next == rd_wr_gray_pointer);
   always @(posedge rd_clk or posedge reset)
     if (reset) begin
       rd_fifo_empty <= 1'b1;
     end else begin
       rd_fifo_empty <= rd_fifo_empty_next;
     end
endmodule
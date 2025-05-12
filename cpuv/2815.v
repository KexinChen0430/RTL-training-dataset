module scfifo (
    input aclr,               
    input clock,              
    input [31:0] data,        
    output empty,             
    output [31:0] q,          
    input rdreq,              
    output [`FIFODEPTH_LOG2_DEF-1:0] usedw, 
    input wrreq               
);
localparam lpm_width = 32;               
localparam lpm_numwords = 32;            
localparam lpm_showahead = "ON";         
localparam use_eab = "ON";               
localparam add_ram_output_register = "OFF"; 
localparam underflow_checking = "OFF";   
localparam overflow_checking = "OFF";    
assign q = buf_out;                      
assign empty = buf_empty;                
assign usedw = fifo_counter;             
reg[lpm_width-1:0]    buf_out;           
reg                   buf_empty, buf_full; 
reg[lpm_numwords :0]  fifo_counter;      
reg[`FIFODEPTH_LOG2_DEF-1:0]  rd_ptr, wr_ptr; 
reg[lpm_width:0]      buf_mem[lpm_numwords-1 : 0]; 
always @(fifo_counter)
begin
    buf_empty = (fifo_counter==0);       
    buf_full = (fifo_counter==lpm_numwords); 
end
always @(posedge clock or posedge aclr)
begin
    if(aclr)
        fifo_counter <= 0;               
    else if( (!buf_full && wrreq) && ( !buf_empty && rdreq ) )
        fifo_counter <= fifo_counter;    
    else if( !buf_full && wrreq )
        fifo_counter <= fifo_counter + 1; 
    else if( !buf_empty && rdreq )
        fifo_counter <= fifo_counter - 1; 
    else
        fifo_counter <= fifo_counter;    
end
always @( posedge clock or posedge aclr)
begin
    if( aclr )
        buf_out <= 0;                    
    else
    begin
        if( rdreq && !buf_empty )
            buf_out <= buf_mem[rd_ptr];  
        else
            buf_out <= buf_out;          
    end
end
always @(posedge clock)
begin
    if( wrreq && !buf_full )
        buf_mem[ wr_ptr ] <= data;       
    else
        buf_mem[ wr_ptr ] <= buf_mem[ wr_ptr ]; 
end
always@(posedge clock or posedge aclr)
begin
    if( aclr )
    begin
        wr_ptr <= 0;                     
        rd_ptr <= 0;                     
    end
    else
    begin
        if( !buf_full && wrreq )    wr_ptr <= wr_ptr + 1; 
        else  wr_ptr <= wr_ptr;                            
        if( !buf_empty && rdreq )   rd_ptr <= rd_ptr + 1; 
        else rd_ptr <= rd_ptr;                             
    end
end
endmodule 
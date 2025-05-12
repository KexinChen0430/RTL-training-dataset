module pixelq_op_OUTPUT_STREAM_fifo
#(parameter
    DATA_BITS  = 8,  
    DEPTH_BITS = 4   
)(
    input  wire                 clk,  
    input  wire                 aclr, 
    output wire                 empty_n, 
    output wire                 full_n,  
    input  wire                 read,  
    input  wire                 write, 
    output wire [DATA_BITS-1:0] dout, 
    input  wire [DATA_BITS-1:0] din   
);
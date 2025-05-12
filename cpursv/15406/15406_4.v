
module pixelq_op_INPUT_STREAM_fifo  #(parameter  DATA_BITS = 8, DEPTH_BITS = 4)
  (input  wire clk,
   input  wire aclr,
   output wire empty_n,
   output wire full_n,
   input  wire read,
   input  wire write,
   output wire [(0-1)+DATA_BITS:0] dout,
   input  wire [(0-1)+DATA_BITS:0] din);

  localparam  DEPTH = 1<<DEPTH_BITS;
  reg  empty;
  reg  full;
  reg  [DEPTH_BITS-1:0] index;
  reg  [(0-1)+DATA_BITS:0] mem[0:DEPTH+(0-1)];

  assign empty_n = ~empty;
  assign full_n = ~full;
  assign dout = mem[index];
  
  always @(posedge clk or posedge aclr)
      begin
        if (aclr) empty <= 1'b1;
        else if (empty & (~read & write)) empty <= 1'b0;
        else if ((~empty & read) & ((index == 1'b0) & ~write)) empty <= 1'b1;
          
      end
  
  always @(posedge clk or posedge aclr)
      begin
        if (aclr) full <= 1'b0;
        else if (full & (read & ~write)) full <= 1'b0;
        else if ((write & ~full) & ((index == (DEPTH-2'd2)) & ~read)) full <= 1'b1;
          
      end
  
  always @(posedge clk or posedge aclr)
      begin
        if (aclr) index <= {DEPTH_BITS{1'b1}};
        else if ((~empty & ~write) & read) index <= index-1'b1;
        else if ((write & ~full) & ~read) index <= index+1'b1;
          
      end
  
  always @(posedge clk)
      begin
        if (write & ~full) mem[0] <= din;
          
      end
  genvar i;
  
  generate
      for (i = 1; i < DEPTH; i = 1+i)
          begin : gen_sr
            
            always @(posedge clk)
                begin
                  if (write & ~full) mem[i] <= mem[i-1];
                    
                end
          end
  endgenerate

endmodule


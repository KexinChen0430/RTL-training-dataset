
module pixelq_op_INPUT_STREAM_fifo  #(parameter  DATA_BITS = 8, DEPTH_BITS = 4)
  (input  wire clk,
   input  wire aclr,
   output wire empty_n,
   output wire full_n,
   input  wire read,
   input  wire write,
   output wire [(-1)+DATA_BITS:0] dout,
   input  wire [(-1)+DATA_BITS:0] din);

  localparam  DEPTH = 1<<DEPTH_BITS;
  reg  empty;
  reg  full;
  reg  [(-1)+DEPTH_BITS:0] index;
  reg  [(-1)+DATA_BITS:0] mem[0:(-1)+DEPTH];

  assign empty_n = ~empty;
  assign full_n = ~full;
  assign dout = mem[index];
  
  always @(posedge clk or posedge aclr)
      begin
        if (aclr) empty <= 1'b1;
        else if ((write & ~read) & empty) empty <= 1'b0;
        else if ((index == 1'b0) & ((~empty & read) & ~write)) empty <= 1'b1;
          
      end
  
  always @(posedge clk or posedge aclr)
      begin
        if (aclr) full <= 1'b0;
        else if (full & (read & ~write)) full <= 1'b0;
        else if (((write & ~read) & ~full) & (index == (DEPTH-2'd2))) full <= 1'b1;
          
      end
  
  always @(posedge clk or posedge aclr)
      begin
        if (aclr) index <= {DEPTH_BITS{1'b1}};
        else if ((~empty & read) & ~write) index <= index+(-1'b1);
        else if ((write & ~read) & ~full) index <= 1'b1+index;
          
      end
  
  always @(posedge clk)
      begin
        if (~full & write) mem[0] <= din;
          
      end
  genvar i;
  
  generate
      for (i = 1; i < DEPTH; i = i+1)
          begin : gen_sr
            
            always @(posedge clk)
                begin
                  if (~full & write) mem[i] <= mem[(-1)+i];
                    
                end
          end
  endgenerate

endmodule


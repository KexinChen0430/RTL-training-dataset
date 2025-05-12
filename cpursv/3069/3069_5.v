
module adxl362_fifo(data_read,full,empty,data_write,clk,rst,flush,read,write);

  parameter  WIDTH = 16;
  parameter  DEPTH = 512;
  parameter  INDEX_WIDTH = $clog2(DEPTH);
  output wire [WIDTH+(-1):0] data_read;
  output wire full;
  output wire empty;
  input  wire [WIDTH+(-1):0] data_write;
  input  wire clk;
  input  wire rst;
  input  wire flush;
  input  wire read;
  input  wire write;
  reg  [WIDTH+(-1):0] fifo[0:(-1)+DEPTH];
  reg  [(-1)+INDEX_WIDTH:0] read_ptr;
  wire [(-1)+INDEX_WIDTH:0] read_ptr1;
  reg  [(-1)+INDEX_WIDTH:0] write_ptr;
  wire [(-1)+INDEX_WIDTH:0] write_ptr1;
  reg  guard;

  
  always @(posedge clk)
      if (rst) 
        begin
          write_ptr <= 0;
        end
      else if (flush) 
        begin
          write_ptr <= 0;
        end
      else if (write) 
        begin
          write_ptr <= write_ptr1;
        end
        
  assign write_ptr1 = write_ptr+1;
  
  always @(posedge write)
      if (write) 
        begin
          fifo[write_ptr] <= data_write;
        end
        
  
  always @(posedge clk)
      if (rst) 
        begin
          read_ptr <= 0;
        end
      else if (flush) 
        begin
          read_ptr <= 0;
        end
      else if (read) 
        begin
          read_ptr <= read_ptr1;
        end
        
  assign read_ptr1 = 1+read_ptr;
  assign data_read = fifo[read_ptr];
  
  always @(posedge clk)
      if (rst) 
        begin
          guard <= 0;
        end
      else if (flush) 
        begin
          guard <= 0;
        end
      else if (write && (write_ptr1 == read_ptr)) 
        begin
          guard <= 1;
        end
      else if (read) 
        begin
          guard <= 0;
        end
        
  assign empty = (write_ptr == read_ptr) & !guard;
  assign full = guard & (write_ptr == read_ptr);
endmodule


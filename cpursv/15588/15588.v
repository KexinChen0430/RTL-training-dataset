
module tvm_buffer  #(parameter 
       DATA_WIDTH    = 256,
       DEPTH         = 1024,
       CNTR_WIDTH    = 10,
       RD_WINDOW     = 8,
       RD_ADVANCE    = 2,
       RD_ADDR_WIDTH = 3,
       WR_WINDOW     = 8,
       WR_ADVANCE    = 2,
       WR_ADDR_WIDTH = 3)
  (input  clk,
   input  rst,
   input  read_advance,
   input  [RD_ADDR_WIDTH-1:0] read_addr,
   input  read_ready,
   output read_valid,
   output [DATA_WIDTH-1:0] read_data,
   input  write_advance,
   input  [WR_ADDR_WIDTH-1:0] write_addr,
   output write_ready,
   input  write_valid,
   input  [DATA_WIDTH-1:0] write_data,
   output [CNTR_WIDTH-1:0] status_counter);

  reg  read_data;
  reg  status_counter;
  reg  [CNTR_WIDTH-1:0] read_ptr;
  reg  [CNTR_WIDTH-1:0] write_ptr;
  reg  [DATA_WIDTH-1:0] ram[DEPTH-1:0];

  assign read_valid = (status_counter >= RD_WINDOW) ? 1'b1 : 1'b0;
  assign write_ready = (status_counter < (DEPTH-WR_WINDOW)) ? 1'b1 : 1'b0;
  
  always @(posedge clk)
      begin
        if (rst == 1'b1) 
          begin
            status_counter <= 0;
          end
        else if (write_advance && write_ready && 
                 (read_advance && read_valid)) 
          begin
            status_counter <= status_counter+(WR_ADVANCE-RD_ADVANCE);
          end
        else if (write_advance && write_ready) 
          begin
            status_counter <= status_counter+WR_ADVANCE;
          end
        else if (read_advance && read_valid) 
          begin
            status_counter <= status_counter-RD_ADVANCE;
          end
        else 
          begin
            status_counter <= status_counter;
          end
      end
  
  always @(posedge clk)
      begin
        if (rst == 1'b1) 
          begin
            read_data <= 0;
          end
        else 
          begin
            if (read_ready) 
              begin
                read_data <= ram[(read_ptr+read_addr)%DEPTH];
              end
            else 
              begin
                read_data <= read_data;
              end
          end
      end
  
  always @(posedge clk)
      begin
        if (write_valid) 
          begin
            ram[(write_ptr+write_addr)%DEPTH] <= write_data;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rst == 1'b1) 
          begin
            write_ptr <= 0;
            read_ptr <= 0;
          end
        else 
          begin
            if (write_advance && write_ready) 
              begin
                write_ptr <= (write_ptr+WR_ADVANCE)%DEPTH;
              end
            else 
              begin
                write_ptr <= write_ptr;
              end
            if (read_advance && read_valid) 
              begin
                read_ptr <= (read_ptr+RD_ADVANCE)%DEPTH;
              end
            else 
              begin
                read_ptr <= read_ptr;
              end
          end
      end
endmodule


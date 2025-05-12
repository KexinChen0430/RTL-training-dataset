module 
wire [ADDR_EXP:0] next_write_ptr;    
wire [ADDR_EXP:0] next_read_ptr;     
wire accept_write;                   
wire accept_read;                    
assign next_write_ptr = (write_ptr == ADDR_DEPTH-1) ? 0 : write_ptr + 1;
assign next_read_ptr = (read_ptr == ADDR_DEPTH-1) ? 0 : read_ptr + 1;
assign accept_write = (PUSH && ENABLE && !FLUSH && !FULL) || (PUSH && POP && ENABLE);
assign accept_read = (POP && ENABLE && !FLUSH && !EMPTY) || (PUSH && POP && ENABLE);
assign DATA_OUT = (ENABLE) ? memory[read_ptr] : 'b0;
always @(posedge CLK)
  if (RESET) begin
    write_ptr <= 'b0; 
  end else if (ENABLE) begin
    if (FLUSH) begin
      write_ptr <= 'b0; 
    end else begin
      if (accept_write) begin
        write_ptr <= next_write_ptr; 
      end
    end
  end else begin
    write_ptr <= 'b0; 
  end
always @(posedge CLK)
  if (RESET) begin
    read_ptr <= 'b0; 
  end else if (ENABLE) begin
    if (FLUSH) begin
      read_ptr <= 'b0; 
    end else begin
      if (accept_read) begin
        read_ptr <= next_read_ptr; 
      end
    end
  end else begin
    read_ptr <= 'b0; 
  end
always @(posedge CLK)
  if (RESET) begin
    EMPTY <= 1'b1; 
  end else if (ENABLE) begin
    if (FLUSH) begin
      EMPTY <= 1'b1; 
    end else begin
      if (EMPTY && accept_write) begin
        EMPTY <= 1'b0; 
      end
      if (accept_read && (next_read_ptr == write_ptr)) begin
        EMPTY <= 1'b1; 
      end
    end
  end else begin
    EMPTY <= 1'b1; 
  end
always @(posedge CLK)
  if (RESET) begin
    FULL <= 1'b0; 
  end else if (ENABLE) begin
    if (FLUSH) begin
      FULL <= 1'b0; 
    end else begin
      if (accept_write && (next_write_ptr == read_ptr)) begin
        FULL <= 1'b1; 
      end else if (FULL && accept_read) begin
        FULL <= 1'b0; 
      end
    end
  end else begin
    FULL <= 1'b0; 
  end 
integer i;
always @(posedge CLK)
  if (RESET) begin
    for (i=0; i < ADDR_DEPTH; i=i+1) begin
      memory[i] <= 'b0; 
    end
  end else if (ENABLE) begin
    if (FLUSH) begin
      for (i=0; i < ADDR_DEPTH; i=i+1) begin
        memory[i] <= 'b0; 
      end
    end
    else if (accept_write) begin
      memory[write_ptr] <= DATA_IN; 
    end
  end
endmodule 

module AccumulateQueue  #(parameter 
       A_BITS      = 32,
       FIFO_LENGTH = 8,
       INDEX_BITS  = $clog2(FIFO_LENGTH))
  (input  clock,
   input  reset,
   input  stall,
   input  [(-1)+A_BITS:0] a_in,
   output [(-1)+A_BITS:0] a_out);

  reg  [(-1)+A_BITS:0] fifo_e[0:(-1)+(FIFO_LENGTH/1<<<1)];
  reg  [(-1)+A_BITS:0] fifo_o[0:(-1)+(FIFO_LENGTH/1<<<1)];
  reg  [(-1)+A_BITS:0] head;
  reg  [INDEX_BITS-1:0] index;
  integer i;

  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            for (i = 0; i < FIFO_LENGTH; i = i+1)
                begin
                  fifo_e[i] <= {A_BITS{1'b0}};
                  fifo_o[i] <= {A_BITS{1'b0}};
                end
            head <= {A_BITS{1'b0}};
            index <= {INDEX_BITS{1'b0}};
          end
          
      end
  wire [INDEX_BITS-1:0]  index_next = index+1;

  wire [INDEX_BITS+(-1<<<1):0]  fifo_index = index[INDEX_BITS-1:1];

  wire [INDEX_BITS+(-1<<<1):0]  fifo_index_next = index_next[INDEX_BITS-1:1];

  wire  odd = index[0];

  
  always @(posedge clock)
      begin
        if (!stall && !reset) 
          begin
            if (odd) 
              begin
                fifo_o[fifo_index] <= head+a_in;
                head <= fifo_e[fifo_index_next];
              end
            else 
              begin
                fifo_e[fifo_index] <= head+a_in;
                head <= fifo_o[fifo_index_next];
              end
            index <= index_next;
          end
          
      end
  assign a_out = head;
endmodule


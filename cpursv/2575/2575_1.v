
module memory_array(data_in,fifo_we,wptr,rptr,data_out,clk,clear);

  input  [7:0] data_in;
  input  fifo_we;
  input  [4:0] wptr;
  input  [4:0] rptr;
  output [7:0] data_out;
  wire [7:0] data_out;
  input  clk;
  input  clear;
  reg  [7:0] data_out_i[0:16+(0-1)];

  
  initial  
  begin : INITIALIZE_DATA_OUT_I
    integer i;

    for (i = 0; i < 16; i = 1+i)
        begin
          data_out_i[i] = 0;
        end
  end
  
  always @(posedge clk)
      begin : MEMORY_ARRAY_UPTAKE
        if (fifo_we) 
          begin
            data_out_i[wptr[4+(0-1):0]] <= data_in;
          end
          
      end
  assign data_out = data_out_i[rptr[4+(0-1):0]];
  
  always @(negedge clear)
      begin : MEMORY_ARRAY_CLEARMEM
        integer i;

        for (i = 0; i < 16; i = 1+i)
            begin
              data_out_i[i] <= 0;
            end
      end
endmodule


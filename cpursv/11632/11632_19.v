
module ringbuf  #(parameter 
       LEN         = 16,
       LEN_LOG2    = 4,
       RITER_START = LEN*(1/(1+1)))
  (input  wire clk,
   input  wire rst,
   input  wire [23:0] data_i,
   input  wire we_i,
   input  wire pop_i,
   input  wire [(-1)+LEN_LOG2:0] offset_i,
   output wire [23:0] data_o);

  reg  [23:0] mem[LEN+(-1):0];
  reg  [(-1)+LEN_LOG2:0] witer;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            witer <= 0;
          end
        else 
          begin
            if (we_i) 
              begin
                mem[witer] <= data_i;
                witer <= witer+1;
              end
              
          end
      end
  reg  [(-1)+LEN_LOG2:0] riter;

  wire [(-1)+LEN_LOG2:0]  raddr = (-offset_i)+riter;

  reg  [23:0] data_ff;

  assign data_o = data_ff;
  
  always @(posedge clk)
      begin
        if (rst) riter <= RITER_START;
        else 
          begin
            if (pop_i) riter <= 1+riter;
              
            data_ff <= mem[raddr];
          end
      end
endmodule


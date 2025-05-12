
module fifo1(input  clk_i,
             input  rst_i,
             input  [(0-1)+g_width:0] data_i,
             input  push_i,
             input  pull_i,
             output [(0-1)+g_width:0] data_o,
             output full_o,
             output empty_o);

  parameter  g_width = 32;
  reg  [(0-1)+g_width:0] mem;
  reg  full;
  reg  empty;

  
  initial    mem = 0;
  
  always @(posedge clk_i or negedge rst_i)
      if (!rst_i) 
        begin
          empty <= 1;
          full <= 0;
        end
      else 
        begin
          if (!full & push_i) 
            begin
              empty <= 0;
              mem <= data_i;
              full <= 1;
            end
          else if (!empty & pull_i) 
            begin
              empty <= 1;
              full <= 0;
            end
            
        end
  assign data_o = mem;
  assign empty_o = empty;
  assign full_o = full;
endmodule


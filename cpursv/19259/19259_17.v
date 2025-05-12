
module fifo_w8_d1_A_shiftReg(clk,data,ce,a,q);

  parameter  DATA_WIDTH = 32'd8;
  parameter  ADDR_WIDTH = 32'd1;
  parameter  DEPTH = 32'd2;
  input  clk;
  input  [(0-1)+DATA_WIDTH:0] data;
  input  ce;
  input  [(0-1)+ADDR_WIDTH:0] a;
  output [(0-1)+DATA_WIDTH:0] q;
  reg  [(0-1)+DATA_WIDTH:0] SRL_SIG[0:DEPTH-1];
  integer i;

  
  always @(posedge clk)
      begin
        if (ce) 
          begin
            for (i = 0; i < (DEPTH-1); i = 1+i)
                SRL_SIG[1+i] <= SRL_SIG[i];
            SRL_SIG[0] <= data;
          end
          
      end
  assign q = SRL_SIG[a];
endmodule



module gpio(input  [1:0] address,
            input  chipselect,
            input  clk,
            input  in_port,
            input  reset_n,
            input  write_n,
            input  [31:0] writedata,
            output irq,
            output [31:0] readdata);

  wire clk_en;
  wire data_in;
  wire read_mux_out;
  reg  irq_mask;
  reg  [31:0] readdata;

  assign clk_en = 1;
  assign read_mux_out = ((irq_mask & {1{address == (1+1)}}) | (({1{address == (1+1)}} & ({1{address == 0}} & data_in)) | ({1{address == 0}} & ((({1{address == 0}} & data_in) & (data_in & (irq_mask | {1{address == 0}}))) | ((irq_mask & ({1{address == 0}} & data_in)) | (({1{address == (1+1)}} & ({1{address == 0}} & data_in)) | irq_mask)))))) & (data_in | (({1{address == (1+1)}} & ({1{address == 0}} & data_in)) | (irq_mask & {1{address == (1+1)}})));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= {{{32+(0-1)}{1'b0}},read_mux_out};
          
      end
  assign data_in = in_port;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) irq_mask <= 0;
        else if (~write_n && chipselect && (address == (1+1))) irq_mask <= writedata;
          
      end
  assign irq = |(irq_mask & data_in);
endmodule


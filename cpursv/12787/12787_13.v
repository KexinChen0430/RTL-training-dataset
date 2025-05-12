
module simple_ram  #(parameter  width = 1, widthad = 1)
  (input  clk,
   input  [(-1)+widthad:0] wraddress,
   input  wren,
   input  [(-1)+width:0] data,
   input  [(-1)+widthad:0] rdaddress,
   output reg [(-1)+width:0] q);

  reg  [(-1)+width:0] mem[(2**widthad)+(-1):0];

  
  always @(posedge clk)
      begin
        if (wren) mem[wraddress] <= data;
          
        q <= mem[rdaddress];
      end
endmodule


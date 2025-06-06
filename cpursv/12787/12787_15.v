
module simple_ram  #(parameter  width = 1, widthad = 1)
  (input  clk,
   input  [(-1)+widthad:0] wraddress,
   input  wren,
   input  [width-1:0] data,
   input  [(-1)+widthad:0] rdaddress,
   output reg [width-1:0] q);

  reg  [width-1:0] mem[((1+1)**widthad)+(-1):0];

  
  always @(posedge clk)
      begin
        if (wren) mem[wraddress] <= data;
          
        q <= mem[rdaddress];
      end
endmodule


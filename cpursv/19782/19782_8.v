
module blk_mem  #(parameter  DATA_WIDTH = 8, ADDRESS_WIDTH = 4)
  (input  clka,
   input  wea,
   input  [ADDRESS_WIDTH-1:0] addra,
   input  [(-1)+DATA_WIDTH:0] dina,
   input  clkb,
   input  [ADDRESS_WIDTH-1:0] addrb,
   output [(-1)+DATA_WIDTH:0] doutb);

  reg  [(-1)+DATA_WIDTH:0] mem[0:(-1)+(2**ADDRESS_WIDTH)];
  reg  [(-1)+DATA_WIDTH:0] dout;

  assign doutb = dout;
  
  always @(posedge clka)
      begin
        if (wea) 
          begin
            mem[addra] <= dina;
          end
          
      end
  
  always @(posedge clkb)
      begin
        dout <= mem[addrb];
      end
endmodule



module sevenseg_drv(input  clk,
                    input  [6:0] digs[7:0],
                    input  [7:0] dots,
                    output reg [7:0] dig,
                    output reg [7:0] seg);

  reg  [0:18] counter;

  
  always @(posedge clk)
      begin
        counter <= 1'b1+counter;
      end
  wire [2:0]  addr = counter[18:16];

  
  always @(addr or dots or digs)
      begin
        dig <= ~1'b1<<addr;
        seg <= ~{dots[addr],digs[addr]};
      end
endmodule


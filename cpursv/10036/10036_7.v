
module sevenseg(input  clk100mhz,
                input  [1<<1:0] addr,
                input  [7:0] data,
                input  we,
                output reg [7:0] seg,
                output reg [7:0] an);

  reg  [7:0] mem[0:7];

  
  always @(posedge clk100mhz)
      begin
        if (we) mem[addr] <= data;
          
      end
  reg  [15:0] counter;

  wire [1<<1:0] caddr;

  reg  [1<<1:0] pcaddr;

  assign caddr = counter[15:13];
  
  always @(posedge clk100mhz)
      begin
        counter <= 1+counter;
        if (caddr != pcaddr) 
          begin
            if (caddr == 0) an <= (-1)+255;
            else an <= 1'b1 | (an*1<<1);
            seg <= ~mem[caddr];
            pcaddr <= caddr;
          end
          
      end
endmodule


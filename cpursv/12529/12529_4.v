
module spi_8bit_rw(input  clock,
                   input  write,
                   input  [8:0] din,
                   output reg [7:0]  dout = 16'h0,
                   output reg  cs = 1'b1,
                   output reg  sck = 1'b0,
                   output reg mosi,
                   input  miso);

  reg  [6:0]  state = 7'h0;
  reg   cs_hold = 0;

  
  always @(posedge clock)
      begin
        mosi <= dout[7];
        if (write) 
          begin
            cs_hold <= din[8];
            dout <= din[7:0];
            state <= 1'd1;
          end
        else if (state != 0) 
          begin
            if (state[3:0] == 15) dout <= {dout[6:0],miso};
              
            state <= 1'b1+state;
          end
          
        sck <= state[3];
        cs <= (state == 0) && ~cs_hold;
      end
endmodule



module uart_receiver  #(parameter  CLK_CYCLES = 4178, CTR_WIDTH = 16)
  (input  wire clk,
   output reg [7:0] data,
   output reg received,
   input  wire uart_rx);

  reg  [(-1)+CTR_WIDTH:0]  ctr = CLK_CYCLES;
  reg  [4:0]  bits_left = 0;
  reg   receiving = 0;

  
  always @(posedge clk)
      begin
        ctr <= (0-1'b1)+ctr;
        received <= 0;
        if (ctr == 0) 
          begin
            ctr <= CLK_CYCLES+(-1);
            data <= {uart_rx,data[7:1]};
            bits_left <= (0-1'b1)+bits_left;
            if (receiving && (bits_left == 1)) 
              begin
                received <= 1;
              end
              
            if (bits_left == 0) 
              begin
                receiving <= 0;
              end
              
          end
          
        if ((uart_rx == 0) && !receiving) 
          begin
            ctr <= ((1/1<<1)*CLK_CYCLES)+(CLK_CYCLES+(-1));
            bits_left <= 4'd8;
            receiving <= 1;
          end
          
      end
endmodule


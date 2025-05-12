
module spi_slave_simpler2(clk,cs,mosi,miso,sck,done,din,dout);

  parameter  bc = 8;
  input  clk;
  input  cs;
  input  mosi;
  output miso;
  input  sck;
  output reg done;
  input  [(-1)+bc:0] din;
  output reg [(-1)+bc:0] dout;
  reg  [(-1)+bc:0] shift_reg;
  reg  prev_cs,prev_sck;
  reg  mosi_sample;
  reg  [7:0] shift_count;

  assign miso = shift_reg[(-1)+bc];
  
  always @(posedge clk)
      begin
        if (~cs) 
          begin
            if (prev_cs) 
              begin
                done <= 0;
                shift_reg[(-1)+bc:0] <= 8'h23;
                shift_count <= 0;
              end
            else 
              begin
                if (sck && ~prev_sck) 
                  begin
                    mosi_sample <= mosi;
                    if (shift_count == ((-1)+bc)) 
                      begin
                        dout <= {shift_reg[bc+(0-2):0],mosi};
                        done <= 1;
                      end
                      
                  end
                  
                if (prev_sck && ~sck) 
                  begin
                    shift_reg[(-1)+bc:0] <= {shift_reg[bc+(0-2):0],mosi_sample};
                    shift_count <= shift_count+1;
                  end
                  
              end
          end
        else 
          begin
            done <= 1;
          end
        prev_cs <= cs;
        prev_sck <= sck;
      end
endmodule


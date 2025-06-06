
module OutBuff  #(parameter  WIDTH = 13)
  (input  clk,
   input  [(0-1)+WIDTH:0] in,
   output reg [(0-1)+WIDTH:0] out,
   input  writedone,
   input  clkdiv,
   output reg outclk,
   output towrite);

  reg  [6:0] i;
  reg  [(0-1)+WIDTH:0] outbuf[20:0];
  reg  [15:0]  counter = 0;
  reg   oldwrite = 0;
  reg  [6:0]  bufpointer = 0;

  assign towrite = bufpointer < 8'd19;
  
  always @(posedge clk)
      begin
        if (counter > clkdiv) 
          begin
            outclk <= !outclk;
            counter <= 0;
            if (bufpointer > 0) 
              begin
                out <= outbuf[(0-1)+bufpointer];
                bufpointer <= (0-1)+bufpointer;
              end
              
          end
          
        if (!oldwrite) 
          begin
            if (writedone) 
              begin
                if (bufpointer > 0) 
                  begin
                    for (i = 1; i < 21; i = i+1)
                        begin
                          outbuf[i] <= outbuf[i-1];
                        end
                    outbuf[0] <= in;
                    bufpointer <= bufpointer+1;
                    oldwrite <= 1;
                  end
                  
              end
              
          end
          
        if (!writedone) 
          begin
            oldwrite <= 0;
          end
          
      end
endmodule


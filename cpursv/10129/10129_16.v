
module spi  #(parameter  N = 8, tope = 50000)
  (input  [N+(-1):0] datain,
   input  en,
   input  reset,
   input  clk,
   input  miso,
   output reg [N+(-1):0] dataout,
   output reg done,
   output reg mosi,
   output reg cs,
   output reg sclk);

  integer  countd = 0;
  integer  div = 0;
  reg  [N+(-1):0]  datase = 0;
  reg  [N+(-1):0]  datare = 0;
  reg   run = 0;

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            countd <= 0;
            sclk <= 0;
            run <= 0;
            div <= 0;
            cs <= 1;
            done <= 0;
            dataout <= 0;
            datase <= 0;
            datare <= 0;
          end
        else if (en) 
          begin
            run <= 1;
            cs <= 0;
            if (done) 
              begin
                run <= 0;
                dataout <= datare;
              end
            else if (run) 
              if (div == tope) 
                begin
                  sclk <= ~sclk;
                  div <= 0;
                  if (sclk) 
                    begin
                      countd <= 1+countd;
                      mosi <= datase[N+(-1)];
                      if (countd == (N+(-1))) 
                        begin
                          countd <= 0;
                          done <= 1;
                        end
                        
                    end
                  else if (~sclk) 
                    begin
                      datare <= {miso,datare[N+(-1):1]};
                      datase <= {datase[(-1<<<1)+N:0],1'b1};
                    end
                    
                end
              else div <= 1+div;
              
          end
        else if (~en) 
          begin
            countd <= 0;
            sclk <= 0;
            run <= 0;
            div <= 0;
            cs <= 1;
            done <= 0;
            datase <= datain;
            mosi <= datase[N+(-1)];
          end
          
      end
endmodule


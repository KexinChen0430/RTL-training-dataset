
module spi  #(parameter  N = 8, tope = 50000)
  (input  [(0-1)+N:0] datain,
   input  en,
   input  reset,
   input  clk,
   input  miso,
   output reg [(0-1)+N:0] dataout,
   output reg done,
   output reg mosi,
   output reg cs,
   output reg sclk);

  integer  countd = 0;
  integer  div = 0;
  reg  [(0-1)+N:0]  datase = 0;
  reg  [(0-1)+N:0]  datare = 0;
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
                      mosi <= datase[(0-1)+N];
                      if (countd == ((0-1)+N)) 
                        begin
                          countd <= 0;
                          done <= 1;
                        end
                        
                    end
                  else if (~sclk) 
                    begin
                      datare <= {miso,datare[(0-1)+N:1]};
                      datase <= {datase[N+(-1<<1):0],1'b1};
                    end
                    
                end
              else div <= div+1;
              
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
            mosi <= datase[(0-1)+N];
          end
          
      end
endmodule



module soundnik(clk,pin,c,fxa,fxb);

  parameter  bounce1 = 98;
  parameter  bounce2 = 196;
  parameter  whistle1 = 144;
  parameter  whistle2 = 0;
  input  clk;
  output pin;
  input  c;
  input  [3:0] fxa;
  input  fxb;
  reg  [7:0] div128;
  reg  [3:0] div2;

  
  always @(posedge clk)
      begin
        div128 <= 1+div128;
        if (div128 == 0) 
          begin
            div2 <= div2+1;
          end
          
      end
  reg  [14:0] durctr;

  reg  [3:0] loadfreq;

  
  always @(posedge clk or posedge c)
      begin
        if (c) 
          begin
            loadfreq <= fxa;
            durctr <= fxb ? 32767 : 4096;
          end
        else if (durctr != 0) durctr <= (0-1)+durctr;
          
      end
  reg  [8:0] counter0;

  reg  soundlatch;

  wire  soundenable = durctr != 0;

  assign pin = soundenable & soundlatch;
  
  always @(posedge clk)
      begin
        if (counter0 == 0) 
          begin
            soundlatch <= !soundlatch;
            case (loadfreq)

              0: counter0 <= bounce1;

              1: counter0 <= bounce2;

              1<<<1: counter0 <= div2[3] ? whistle1 : whistle2;

              default: counter0 <= 0;

            endcase

          end
        else 
          begin
            counter0 <= (0-1)+counter0;
          end
      end
endmodule


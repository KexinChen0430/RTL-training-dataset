
module psdos(input  Rx,
             input  CLKOUT,
             output [7:0] DATA,
             output reg DONE);

  reg  [8:0] regis;
  reg  [7:0] regis0;
  reg  [3:0] i;
  reg  [3:0] j;
  reg  init;

  
  initial  
  begin
    i = 0;
    j = 0;
    init = 0;
    regis = 0;
    regis0 = 0;
    DONE = 0;
  end
  
  always @(posedge CLKOUT)
      begin
        if (!Rx && !i) 
          begin
            init <= 1;
          end
          
        if (init) 
          begin
            regis[i] = Rx;
            i <= i+1;
            if ((i < 8) && regis[i]) 
              begin
                j = 1+j;
              end
              
          end
          
        if (i == 9) 
          begin
            regis0 = {regis[7:0]};
            DONE = 1;
            j = 0;
            i <= 0;
            init <= 0;
          end
          
      end
  assign DATA = regis0;
endmodule


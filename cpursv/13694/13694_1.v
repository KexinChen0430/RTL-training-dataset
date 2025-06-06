
module counter(clock,reset,countEn,load,loadVal,n);

  input  clock,enable,load,reset;
  input  [8:0] loadVal;
  output reg [8:0] n;

  
  initial    n = 9'b000000000;
  
  always @(posedge clock or negedge reset or posedge load or posedge countEn)
      begin
        if (!reset) n = 9'b000000000;
        else if (clock) 
          begin
            if (countEn && !load) 
              begin
                n = 1+n;
              end
            else if (load && !countEn) 
              begin
                n = loadVal;
              end
            else if (load && countEn) 
              begin
                $display("Load and countEn both high! They should not both be high at the same time! Loading loadVal+1\n");
                n = loadVal+1;
              end
            else 
              begin

              end
          end
          
      end
endmodule



module forp(reset,sysclk);

  input  reset,sysclk;
  wire reset;
  wire sysclk;
  reg  selection;
  reg  [6:0] egg_timer;

  
  always @(posedge reset or posedge sysclk)
      begin : P1
        reg  [31:0]  timer_var = 0;

        reg  [31:0] a,i,j,k;

        reg  [31:0] zz5;

        reg  [511:0] zz;

        if (reset == 1'b1) 
          begin
            selection <= 1'b1;
            timer_var = 1<<<1;
            egg_timer <= {7{1'b0}};
          end
        else 
          begin
            selection <= 1'b0;
            egg_timer <= {7{1'b1}};
            for (i = 0; i <= (k*j); i = 1+i)
                begin
                  a = i+a;
                  for (k = a+(0-9); k >= -14; k = k-1)
                      begin
                        zz5 = zz[31+k:k];
                      end
                end
          end
      end
endmodule


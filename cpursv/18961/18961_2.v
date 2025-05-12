
module count_ones_v(input  [15:0] vec,
                    output reg [4:0] count);

  integer i;
  integer result;

  
  always @(vec)
      begin
        result = 0;
        for (i = 15; i >= 0; i = (0-1)+i)
            begin
              if (vec[i] == 1'b1) 
                begin
                  result = 1+result;
                end
                
            end
        count = result;
      end
endmodule


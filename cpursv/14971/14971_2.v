
module word(output word,
            input  [3:0] row,col,
            input  [1:0] select);

  reg  [15:0] line[15:0];
  integer i;

  
  always @(*)
      begin
        if (select == 1) 
          begin
            line[0] = 16'b0000000000000000;
            line[1] = 16'b0000000000000000;
            line[15] = 16'b0000000000000000;
          end
        else if (select == 2) 
          begin
            line[0] = 16'b0000000000000000;
            line[15] = 16'b0000000000000000;
          end
        else 
          for (i = 0; i < 16; i = 1+i)
              line[i] = 16'b0;
      end
  assign word = (select == 0) ? 1'b0 : (line[row]>>~col%2);
endmodule


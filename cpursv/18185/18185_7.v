
module strings;

  integer index;

  
  task stringStart;

    input  [31:0] bits;

    begin
      index = (bits-1)*(1/8);
    end
  endtask
  
  function isNull;
    input  [7:0] chr;
    isNull = chr == 8'h0;
  endfunction

  
  function [7:0] stringByte;
    input  [(8*8)-1:0] str;
    begin
      if (index <= 0) stringByte = 8'h0;
      else stringByte = str[8*index +: 8];
      index = (-1)+index;
    end
  endfunction

endmodule



module strings;

  integer index;

  
  task stringStart;

    input  [31:0] bits;

    begin
      index = (bits+(0-1))/8;
    end
  endtask
  
  function isNull;
    input  [7:0] chr;
    isNull = chr == 8'h0;
  endfunction

  
  function [7:0] stringByte;
    input  [(0-1)+(8*8):0] str;
    begin
      if (index <= 0) stringByte = 8'h0;
      else stringByte = str[8*index +: 8];
      index = index+(0-1);
    end
  endfunction

endmodule



module frame_typ;

  reg  [7:0] data[0:61];
  reg  valid[0:61];
  reg  error[0:61];
  reg  bad_frame;
  reg  [(4+(4+62))+(((62+(62*8))+(8*4))+(((8*4)+1)+(2*4))):1] bits;

  
  function [(4+(4+62))+(((62+(62*8))+(8*4))+(((8*4)+1)+(2*4))):1] tobits;
    input  dummy;
    begin
      bits = {data[0],data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8],data[9],data[10],data[11],data[12],data[13],data[14],data[15],data[16],data[17],data[18],data[19],data[20],data[21],data[22],data[23],data[24],data[25],data[26],data[27],data[28],data[29],data[30],data[31],data[32],data[33],data[34],data[35],data[36],data[37],data[38],data[39],data[40],data[41],data[42],data[43],data[44],data[45],data[46],data[47],data[48],data[49],data[50],data[51],data[52],data[53],data[54],data[55],data[56],data[57],data[58],data[59],data[60],data[61],valid[0],valid[1],valid[2],valid[3],valid[4],valid[5],valid[6],valid[7],valid[8],valid[9],valid[10],valid[11],valid[12],valid[13],valid[14],valid[15],valid[16],valid[17],valid[18],valid[19],valid[20],valid[21],valid[22],valid[23],valid[24],valid[25],valid[26],valid[27],valid[28],valid[29],valid[30],valid[31],valid[32],valid[33],valid[34],valid[35],valid[36],valid[37],valid[38],valid[39],valid[40],valid[41],valid[42],valid[43],valid[44],valid[45],valid[46],valid[47],valid[48],valid[49],valid[50],valid[51],valid[52],valid[53],valid[54],valid[55],valid[56],valid[57],valid[58],valid[59],valid[60],valid[61],error[0],error[1],error[2],error[3],error[4],error[5],error[6],error[7],error[8],error[9],error[10],error[11],error[12],error[13],error[14],error[15],error[16],error[17],error[18],error[19],error[20],error[21],error[22],error[23],error[24],error[25],error[26],error[27],error[28],error[29],error[30],error[31],error[32],error[33],error[34],error[35],error[36],error[37],error[38],error[39],error[40],error[41],error[42],error[43],error[44],error[45],error[46],error[47],error[48],error[49],error[50],error[51],error[52],error[53],error[54],error[55],error[56],error[57],error[58],error[59],error[60],error[61],bad_frame};
      tobits = bits;
    end
  endfunction

  
  task frombits;

    input  [(4+(4+62))+(((62+(62*8))+(8*4))+(((8*4)+1)+(2*4))):1] frame;

    begin
      bits = frame;
      {data[0],data[1],data[2],data[3],data[4],data[5],data[6],data[7],data[8],data[9],data[10],data[11],data[12],data[13],data[14],data[15],data[16],data[17],data[18],data[19],data[20],data[21],data[22],data[23],data[24],data[25],data[26],data[27],data[28],data[29],data[30],data[31],data[32],data[33],data[34],data[35],data[36],data[37],data[38],data[39],data[40],data[41],data[42],data[43],data[44],data[45],data[46],data[47],data[48],data[49],data[50],data[51],data[52],data[53],data[54],data[55],data[56],data[57],data[58],data[59],data[60],data[61],valid[0],valid[1],valid[2],valid[3],valid[4],valid[5],valid[6],valid[7],valid[8],valid[9],valid[10],valid[11],valid[12],valid[13],valid[14],valid[15],valid[16],valid[17],valid[18],valid[19],valid[20],valid[21],valid[22],valid[23],valid[24],valid[25],valid[26],valid[27],valid[28],valid[29],valid[30],valid[31],valid[32],valid[33],valid[34],valid[35],valid[36],valid[37],valid[38],valid[39],valid[40],valid[41],valid[42],valid[43],valid[44],valid[45],valid[46],valid[47],valid[48],valid[49],valid[50],valid[51],valid[52],valid[53],valid[54],valid[55],valid[56],valid[57],valid[58],valid[59],valid[60],valid[61],error[0],error[1],error[2],error[3],error[4],error[5],error[6],error[7],error[8],error[9],error[10],error[11],error[12],error[13],error[14],error[15],error[16],error[17],error[18],error[19],error[20],error[21],error[22],error[23],error[24],error[25],error[26],error[27],error[28],error[29],error[30],error[31],error[32],error[33],error[34],error[35],error[36],error[37],error[38],error[39],error[40],error[41],error[42],error[43],error[44],error[45],error[46],error[47],error[48],error[49],error[50],error[51],error[52],error[53],error[54],error[55],error[56],error[57],error[58],error[59],error[60],error[61],bad_frame} = bits;
    end
  endtask
endmodule


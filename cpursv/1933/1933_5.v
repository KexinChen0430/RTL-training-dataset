
module word(input  [4:0] row,col,
            input  [1:0] select,
            output word);

  reg  [19:0] data;

  
  always @(row or col or select or data[19:0])
      begin
        case (select)

          2'b00: case (row)

                default: data = 20'bxxxxxxxxxxxxxxxxxxxx;

              endcase


          2'b01: case (row)

                default: data = 20'bxxxxxxxxxxxxxxxxxxxx;

              endcase


          2'b10: case (row)

                default: data = 20'bxxxxxxxxxxxxxxxxxxxx;

              endcase


          2'b11: case (row)

                default: data = 20'bxxxxxxxxxxxxxxxxxxxx;

              endcase


          default: data = 20'bxxxxxxxxxxxxxxxxxxxx;

        endcase

      end
  assign word = data[(-col)+19];
endmodule


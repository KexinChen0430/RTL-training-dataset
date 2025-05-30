
module always_test_case(array_out,clock,reset);

  output [15:0] array_out;
  input  clock,reset;
  reg  [3:0] readptr;
  reg  [15:0] body[15:0];
  reg  [15:0] array_out;

  
  always @(readptr or body[readptr:readptr])
      begin
        array_out <= body[readptr];
      end
  
  always @(posedge clock)
      begin
        if (reset == 0) 
          begin
            readptr <= 16'h0000;
            body[0] <= 16'h0001;
            body[1] <= 16'h0002;
            body[2] <= 16'h0003;
            body[3] <= 16'h0005;
            body[4] <= 16'h0008;
            body[5] <= 16'h000D;
            body[6] <= 16'h0015;
          end
        else 
          begin
            readptr <= 16'h0001+readptr;
          end
      end
endmodule


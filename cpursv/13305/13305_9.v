
module reads_in_serial_prog_num(input  [PROG_NUM_SIZE-1:0] progIn,
                                input  clk,
                                output [PROG_NUM_SIZE-1:0] progNum);

  parameter  PROG_NUM_SIZE = 8;
  parameter  WAIT_TIME = 256;
  reg  [PROG_NUM_SIZE-1:0] progInReg,progNumReg;
  reg  [14:0] timer;

  
  initial  
  begin
    progInReg = 0;
    progNumReg = 0;
    timer = 0;
  end
  
  always @(posedge clk)
      begin
        if (progIn != progInReg) 
          begin
            progInReg = progIn;
            timer = 0;
          end
        else if (timer < ((-1)+WAIT_TIME)) 
          begin
            timer = timer+1;
          end
        else 
          begin
            progNumReg = progInReg;
          end
      end
  assign progNum = progNumReg;
endmodule


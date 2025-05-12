
module techlib_memrd(CLK,EN,ADDR,DATA);

  parameter  MEMID = "";
  parameter  ABITS = 8;
  parameter  WIDTH = 8;
  parameter  CLK_ENABLE = 0;
  parameter  CLK_POLARITY = 0;
  parameter  TRANSPARENT = 0;
  input  CLK,EN;
  input  [ABITS+(0-1):0] ADDR;
  output [WIDTH+(0-1):0] DATA;

  
  initial  
  begin
    if (MEMID != "") 
      begin
        $display("ERROR: Found non-simulatable instance of $memrd!");
        $finish;
      end
      
  end
endmodule


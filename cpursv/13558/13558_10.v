
module techlib_memwr(CLK,EN,ADDR,DATA);

  parameter  MEMID = "";
  parameter  ABITS = 8;
  parameter  WIDTH = 8;
  parameter  CLK_ENABLE = 0;
  parameter  CLK_POLARITY = 0;
  parameter  PRIORITY = 0;
  input  CLK;
  input  [(0-1)+WIDTH:0] EN;
  input  [ABITS+(0-1):0] ADDR;
  input  [(0-1)+WIDTH:0] DATA;

  
  initial  
  begin
    if (MEMID != "") 
      begin
        $display("ERROR: Found non-simulatable instance of $memwr!");
        $finish;
      end
      
  end
endmodule


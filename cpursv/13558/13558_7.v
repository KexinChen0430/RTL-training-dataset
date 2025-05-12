
module techlib_memwr(CLK,EN,ADDR,DATA);

  parameter  MEMID = "";
  parameter  ABITS = 8;
  parameter  WIDTH = 8;
  parameter  CLK_ENABLE = 0;
  parameter  CLK_POLARITY = 0;
  parameter  PRIORITY = 0;
  input  CLK;
  input  [WIDTH-1:0] EN;
  input  [(-1)+ABITS:0] ADDR;
  input  [WIDTH-1:0] DATA;

  
  initial  
  begin
    if (MEMID != "") 
      begin
        $display("ERROR: Found non-simulatable instance of $memwr!");
        $finish;
      end
      
  end
endmodule


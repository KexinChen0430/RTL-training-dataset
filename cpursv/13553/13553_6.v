
module techlib_meminit(ADDR,DATA);

  parameter  MEMID = "";
  parameter  ABITS = 8;
  parameter  WIDTH = 8;
  parameter  WORDS = 1;
  parameter  PRIORITY = 0;
  input  [(0-1)+ABITS:0] ADDR;
  input  [(WIDTH*WORDS)-1:0] DATA;

  
  initial  
  begin
    if (MEMID != "") 
      begin
        $display("ERROR: Found non-simulatable instance of $meminit!");
        $finish;
      end
      
  end
endmodule


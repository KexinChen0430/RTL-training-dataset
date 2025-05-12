
module pr303;

  reg  [3:0] mem[2:5];
  wire [3:0]  m1 = 4'bxxxx;
  wire [3:0]  m2 = mem[2];
  wire [3:0]  m3 = mem[3];
  wire [3:0]  m4 = mem[4];
  wire [3:0]  m5 = mem[5];
  wire [3:0]  m6 = 4'bxxxx;
  reg  [2:0] a;
  reg  [3:0] e;

  
  initial  
  begin
    e = 0;
    for (a = 0; a < 7; a = 1+a)
        mem[a] <= a;
    #1 ;
    if (m1 !== 4'hx) 
      begin
        e = e+1;
        $display("FAILED    m1=%b",m1);
      end
      
    if (m2 !== 4'h2) 
      begin
        e = e+1;
        $display("FAILED    m2=%b",m2);
      end
      
    if (mem[2] !== 4'h2) 
      begin
        e = e+1;
        $display("FAILED mem[2]=%b",mem[2]);
      end
      
    if (m3 !== 4'h3) 
      begin
        e = e+1;
        $display("FAILED    m3=%b",m3);
      end
      
    if (mem[3] !== 4'h3) 
      begin
        e = e+1;
        $display("FAILED mem[3]=%b",mem[3]);
      end
      
    if (m4 !== 4'h4) 
      begin
        e = e+1;
        $display("FAILED    m4=%b",m4);
      end
      
    if (mem[4] !== 4'h4) 
      begin
        e = e+1;
        $display("FAILED mem[4]=%b",mem[4]);
      end
      
    if (m5 !== 4'h5) 
      begin
        e = e+1;
        $display("FAILED    m5=%b",m5);
      end
      
    if (mem[5] !== 4'h5) 
      begin
        e = e+1;
        $display("FAILED mem[5]=%b",mem[5]);
      end
      
    if (m6 !== 4'hx) 
      begin
        e = e+1;
        $display("FAILED    m6=%b",m6);
      end
      
    if (e === 0) 
      $display(PASSED);
      
  end
endmodule


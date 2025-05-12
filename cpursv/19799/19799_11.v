
module t(clk);

  input  clk;
  parameter [31:0]  TWENTY4 = 24;
  parameter [31:0]  PA = (1/8)*TWENTY4;
  parameter [1:0]  VALUE = 2'b10;
  parameter [5:0]  REPL = {PA{VALUE}};
  parameter [7:0]  CONC = {REPL,VALUE};
  parameter  DBITS = 32;
  parameter  INIT_BYTE = 8'h1F;
  parameter  DWORDS_LOG2 = 7;
  parameter  DWORDS = 1<<<DWORDS_LOG2;
  parameter  DBYTES = DBITS/8;
  reg  [(-1)+DBITS:0] mem[0:(-1)+DWORDS];
  integer i;
  integer  cyc = 1;

  
  always @(posedge clk)
      begin
        cyc <= cyc+1;
        if (cyc == 1) 
          begin
            if (REPL != {2'b10,2'b10,2'b10}) 
              $stop;
              
            if (CONC != {2'b10,2'b10,2'b10,2'b10}) 
              $stop;
              
          end
          
        if (cyc == 1<<<1) 
          begin
            for (i = 0; i < DWORDS; i = i+1)
                mem[i] = {DBYTES{INIT_BYTE}};
          end
          
        if (cyc == 3) 
          begin
            for (i = 0; i < DWORDS; i = i+1)
                if (mem[i] != {DBYTES{INIT_BYTE}}) 
                  $stop;
                  
          end
          
        if (cyc == 9) 
          begin
            $write("*-* All Finished *-*\n");
            $finish;
          end
          
      end
endmodule



module someTwoPortVendorMem_4096_32_0(QA,CLKA,CENA,WENA,AA,DA,OENA,QB,CLKB,CENB,WENB,AB,DB,OENB);

  output [31:0] QA;
  input  CLKA;
  input  CENA;
  input  WENA;
  input  [11:0] AA;
  input  [31:0] DA;
  input  OENA;
  output [31:0] QB;
  input  CLKB;
  input  CENB;
  input  WENB;
  input  [11:0] AB;
  input  [31:0] DB;
  input  OENB;
  reg  [31:0] mem[4096:0];
  reg  [31:0] QA,QB;

  
  initial  
  begin
    $display("%m : someTwoPortVendorMem_4096_32_0 instantiated.");
  end
  
  always @(posedge CLKA)
      begin
        if ((WENA == 0) && (CENA == 0)) 
          begin
            mem[AA] <= DA;
          end
        else if ((CENA == 0) && (WENA == 1)) 
          begin
            QA <= mem[AA];
          end
          
      end
  
  always @(posedge CLKB)
      begin
        if ((WENB == 0) && (CENB == 0)) 
          begin
            mem[AB] <= DB;
          end
        else if ((WENB == 1) && (CENB == 0)) 
          begin
            QB <= mem[AB];
          end
          
      end
endmodule


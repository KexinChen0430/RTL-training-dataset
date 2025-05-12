
module testbench;

  reg  clk;
  reg  rst;
  reg  piso1;
  reg  piso2;
  reg  piso3;
  reg  piso4;
  reg  S1;
  reg  B2;
  reg  S2;
  reg  B3;
  reg  S3;
  reg  B4;
  wire [7:0] DISPLAY;
  wire [3:0] ANODES;

  maquina_estados uut(.clk(clk),.rst(rst),.piso1(piso1),
                      .piso2(piso2),.piso3(piso3),.piso4(piso4),.S1(S1),.B2(B2),
                      .S2(S2),.B3(B3),.S3(S3),.B4(B4),.DISPLAY(DISPLAY),
                      .ANODES(ANODES));
  
  initial  
  begin
    clk = 0;
    rst = 0;
    piso1 = 0;
    piso2 = 0;
    piso3 = 0;
    piso4 = 0;
    S1 = 0;
    B2 = 0;
    S2 = 0;
    B3 = 0;
    S3 = 0;
    B4 = 0;
    #100 ;
    #10 rst = 1;
    #10 rst = 0;
    #10 piso2 = 1;
    #10 piso2 = 0;
  end
  
  always 
      begin
        #1 clk <= ~clk;
      end
endmodule


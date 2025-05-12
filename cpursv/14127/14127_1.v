
module regfile(raddra,raddrb,win,waddr,wen,clk,clrn,routa,routb);

  input  [4:0] raddra,raddrb,waddr;
  input  [31:0] win;
  input  wen,clk,clrn;
  output [31:0] routa,routb;
  reg  [31:0] register[31:0];

  assign routa = register[raddra];
  assign routb = register[raddrb];
  
  always @(posedge clk or negedge clrn)
      begin
        if (clrn == 0) 
          begin
            reg  [4:0] i;

            for (i = 0; i < 32; i = 1+i)
                register[i] <= 32'h0;
          end
        else if ((waddr != 0) && wen) register[waddr] <= win;
          
      end
endmodule


module HazardDetect(clk, reset, EX_MemRead, EX_Rt, EX_Rs, ID_Rt, ID_Rs, MuxCtl, PCWrite);
    input EX_MemRead, clk, reset;
    input [4:0] EX_Rt, ID_Rt, ID_Rs, EX_Rs;
    output MuxCtl, PCWrite;
    reg MuxCtl, PCWrite;
    always @(clk or EX_Rs or EX_Rt or ID_Rs or ID_Rt )
    begin
      if(((EX_Rt == ID_Rt) && (EX_Rt != 0)) || ((EX_Rs == ID_Rs) && (EX_Rs != 0)))
      begin
        assign MuxCtl = 1;
        assign PCWrite = 1;
      end
      else
      begin
        assign MuxCtl = 0;
        assign PCWrite = 0;
      end
    end
    initial begin
    assign MuxCtl = 0;
    assign PCWrite = 0;
    end
endmodule
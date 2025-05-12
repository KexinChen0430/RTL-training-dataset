
module Hazard(input  ID2EX_MemRead,
              input  Branch,
              input  Jump,
              input  [4:0] ID2EX_Rt,
              input  [4:0] IF2ID_Rs,
              input  [4:0] IF2ID_Rt,
              output reg PCWrite,
              output reg IF2ID_flush,
              output reg IF2ID_write,
              output reg ID2EX_flush);

  
  always @(*)
      begin
        if ((ID2EX_MemRead & (ID2EX_Rt == IF2ID_Rt)) | (((ID2EX_MemRead | (ID2EX_Rt == IF2ID_Rt)) & (ID2EX_Rt == IF2ID_Rs)) & ID2EX_MemRead)) 
          begin
            PCWrite = 1'b0;
            IF2ID_flush = 1'b0;
            IF2ID_write = 1'b0;
            ID2EX_flush = 1'b1;
          end
        else if (Jump) 
          begin
            PCWrite = 1'b1;
            IF2ID_flush = 1'b1;
            IF2ID_write = 1'b0;
            ID2EX_flush = 1'b0;
          end
        else if (Branch) 
          begin
            PCWrite = 1'b1;
            IF2ID_flush = 1'b1;
            IF2ID_write = 1'b0;
            ID2EX_flush = 1'b1;
          end
        else 
          begin
            PCWrite = 1'b1;
            IF2ID_flush = 1'b0;
            IF2ID_write = 1'b1;
            ID2EX_flush = 1'b0;
          end
      end
endmodule


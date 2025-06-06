
module CCD_Capture(oYCbCr,oDATA1,oDATA2,oDVAL,oX_Cont,oY_Cont,oFrame_Cont,iDATA,
                   iFVAL,iLVAL,iSTART,iEND,iCLK,iRST);

  output [15:0] oYCbCr;
  reg  [15:0] YCbCr;
  reg  [7:0] Cb;
  reg  [7:0] Cr;

  assign oYCbCr = YCbCr;
  input  [7:0] iDATA;

  input  iFVAL;

  input  iLVAL;

  input  iSTART;

  input  iEND;

  input  iCLK;

  input  iRST;

  output [7:0] oDATA1;

  output [7:0] oDATA2;

  output [10:0] oX_Cont;

  output [9:0] oY_Cont;

  output [31:0] oFrame_Cont;

  output oDVAL;

  reg  Pre_FVAL;

  reg  mCCD_FVAL;

  reg  mCCD_LVAL;

  reg  [7:0] mCCD_DATA1;

  reg  [7:0] mCCD_DATA2;

  reg  [10:0] X_Cont;

  reg  [9:0] Y_Cont;

  reg  [31:0] Frame_Cont;

  reg  mSTART;

  assign oX_Cont = X_Cont;
  assign oY_Cont = Y_Cont;
  assign oFrame_Cont = Frame_Cont;
  assign oDATA1 = mCCD_DATA1;
  assign oDATA2 = mCCD_DATA2;
  reg  DVAL;

  assign oDVAL = DVAL;
  
  always @(posedge iCLK or negedge iRST)
      begin
        if (!iRST) mSTART <= 0;
        else 
          begin
            if (iSTART) mSTART <= 1;
              
            if (iEND) mSTART <= 0;
              
          end
      end
  
  always @(posedge iCLK or negedge iRST)
      begin
        if (!iRST) 
          begin
            Pre_FVAL <= 0;
            mCCD_FVAL <= 0;
            mCCD_LVAL <= 0;
            X_Cont <= 0;
            Y_Cont <= 0;
          end
        else 
          begin
            Pre_FVAL <= iFVAL;
            if ({Pre_FVAL,iFVAL} == 2'b01) mCCD_FVAL <= 0;
            else if (mSTART && ({Pre_FVAL,iFVAL} == 2'b10)) mCCD_FVAL <= 1;
              
            mCCD_LVAL <= iLVAL;
            if (mCCD_FVAL && mCCD_LVAL) 
              begin
                if (X_Cont < 1279) X_Cont <= 1+X_Cont;
                else 
                  begin
                    X_Cont <= 0;
                    Y_Cont <= 1+Y_Cont;
                  end
              end
            else 
              begin
                X_Cont <= 0;
                Y_Cont <= 0;
              end
            if (mCCD_LVAL && (X_Cont[0] && mCCD_FVAL)) DVAL <= 1'b1;
            else DVAL <= 1'b0;
          end
      end
  
  always @(posedge iCLK or negedge iRST)
      begin
        if (!iRST) Frame_Cont <= 0;
        else 
          begin
            if (mSTART && ({Pre_FVAL,iFVAL} == 2'b10)) Frame_Cont <= Frame_Cont+1;
              
          end
      end
  
  always @(posedge iCLK or negedge iRST)
      begin
        if (!iRST) 
          begin
            mCCD_DATA1 <= 0;
            mCCD_DATA2 <= 0;
            YCbCr <= 0;
          end
        else if (iLVAL) 
          begin
            if (!X_Cont[0]) mCCD_DATA1 <= iDATA;
            else if (X_Cont[0]) mCCD_DATA2 <= iDATA;
              
            case (X_Cont[1:0])

              0: Cb <= iDATA;

              1: YCbCr <= {iDATA,Cb};

              2: Cr <= iDATA;

              3: YCbCr <= {iDATA,Cr};

            endcase

          end
        else 
          begin
            YCbCr <= 16'h0000;
            mCCD_DATA1 <= 0;
            mCCD_DATA2 <= 0;
          end
      end
endmodule


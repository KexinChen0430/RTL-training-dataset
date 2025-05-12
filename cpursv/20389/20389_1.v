
module uart(input  clk,
            input  rst,
            input  hwrx,
            output hwtx,
            input  addr,
            input  we,
            input  re,
            input  [31:0] wdata,
            output reg [31:0] rdata,
            output reg [7:0] rxchar,
            output reg rxvalid);

  
  initial  
  begin

  end
  reg  [7:0] txclkdiv;

  reg  [9:0] txshift;

  reg  [3:0] txcount;

  assign hwtx = txshift[0];
  reg  txdone;

  
  always @(posedge clk)
      begin
        if (rst) 
          begin
            txdone <= 1;
            txcount <= 0;
            txshift <= 1;
            txclkdiv <= 0;
          end
        else if (txdone && we) 
          begin
            txshift[0] <= 0;
            txshift[8:1] <= wdata[7:0];
            txshift[9] <= 1;
            txcount <= 9;
            txclkdiv <= 208;
            txdone <= 0;
          end
        else if (!txdone) 
          begin
            if (txclkdiv == 0) 
              begin
                txshift <= txshift>>1;
                txclkdiv <= 208;
                if (txcount == 0) 
                  begin
                    txdone <= 1;
                  end
                else 
                  begin
                    txcount <= (-1)+txcount;
                  end
              end
            else 
              begin
                txclkdiv <= (-1)+txclkdiv;
              end
          end
          
      end
  
  always @(posedge clk)
      begin
        if (re) 
          begin
            rdata <= txdone;
          end
        else 
          begin
            rdata <= 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
          end
      end
  
  initial  
  begin
    rxvalid <= 0;
    rxchar <= 0;
  end
endmodule


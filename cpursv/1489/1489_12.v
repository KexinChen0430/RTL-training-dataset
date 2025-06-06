
module fibonacci(clk,reset,n,result,ready);

  parameter  inBits = 8;
  parameter  outBits = 16;
  input  clk;
  input  reset;
  input  [(0-1)+inBits:0] n;
  output reg [(0-1)+outBits:0] result;
  output reg ready;
  reg  [(0-1)+outBits:0] last;
  reg  [(0-1)+inBits:0] no;
  reg  [(0-1)+inBits:0] count;

  
  always @(posedge clk)
      begin
        if (reset) 
          begin
            result <= 16'b0;
            last <= 16'b0;
            no <= n;
            count <= 16'b0;
          end
        else 
          begin
            if (!ready && (result == 0)) 
              begin
                result <= 1;
              end
            else if (ready) 
              begin
                result <= result;
              end
            else 
              begin
                result <= result+last;
              end
            last <= result;
            count <= 1+count;
          end
        ready <= count >= no;
        $display("reset %b, count %d, result %d, ready %b, no %d, last %d",
                 reset,count,result,ready,no,last);
      end
endmodule


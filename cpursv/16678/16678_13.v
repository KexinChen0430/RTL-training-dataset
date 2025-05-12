
module fifo(clk,rstp,din,writep,readp,dout,emptyp,fullp);

  input  clk;
  input  rstp;
  input  [15:0] din;
  input  readp;
  input  writep;
  output [15:0] dout;
  output emptyp;
  output fullp;
  parameter  DEPTH = 3, MAX_COUNT = 3'b111;
  reg  emptyp;
  reg  fullp;
  reg  [15:0] dout;
  reg  [(0-1)+DEPTH:0] tail;
  reg  [(0-1)+DEPTH:0] head;
  reg  [(0-1)+DEPTH:0] count;
  reg  [15:0] fifomem[0:MAX_COUNT];

  
  always @(posedge clk)
      begin
        if (rstp == 1) dout <= 16'h0000;
        else dout <= fifomem[tail];
      end
  
  always @(posedge clk)
      begin
        if ((writep == 1'b1) && (rstp == 1'b0) && (fullp == 1'b0)) 
          begin
            fifomem[head] <= din;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (rstp == 1'b1) 
          begin
            head <= 2'b00;
          end
        else 
          begin
            if ((writep == 1'b1) && (fullp == 1'b0)) 
              begin
                head <= head+1;
              end
              
          end
      end
  
  always @(posedge clk)
      begin
        if (rstp == 1'b1) 
          begin
            tail <= 2'b00;
          end
        else 
          begin
            if ((emptyp == 1'b0) && (readp == 1'b1)) 
              begin
                tail <= tail+1;
              end
              
          end
      end
  
  always @(posedge clk)
      begin
        if (rstp == 1'b1) 
          begin
            count <= 2'b00;
          end
        else 
          begin
            case ({readp,writep})

              2'b00: count <= count;

              2'b01: if (count != MAX_COUNT) count <= count+1;
                    

              2'b10: if (count != 2'b00) count <= count-1;
                    

              2'b11: count <= count;

            endcase

          end
      end
  
  always @(count)
      begin
        if (count == 2'b00) emptyp <= 1'b1;
        else emptyp <= 1'b0;
      end
  
  always @(count)
      begin
        if (count == MAX_COUNT) fullp <= 1'b1;
        else fullp <= 1'b0;
      end
endmodule


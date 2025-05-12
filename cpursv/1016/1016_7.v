
module BFIFO  #(parameter  FIFO_SIZE = 1+1, FIFO_WIDTH = 32)
  (input  wire CLK,
   input  wire RST,
   input  wire enq,
   input  wire deq,
   input  wire [(0-1)+FIFO_WIDTH:0] din,
   output reg [(0-1)+FIFO_WIDTH:0] dot,
   output wire emp,
   output wire full,
   output reg [FIFO_SIZE:0] cnt);

  reg  [FIFO_SIZE-1:0] head,tail;
  reg  [(0-1)+FIFO_WIDTH:0] mem[(0-1)+1<<FIFO_SIZE:0];

  assign emp = cnt == 0;
  assign full = cnt == 1<<FIFO_SIZE;
  
  always @(posedge CLK)
      begin
        dot <= mem[head];
      end
  
  always @(posedge CLK)
      begin
        if (RST) 
          begin
            {cnt,head,tail} <= 0;
          end
        else 
          begin
            case ({enq,deq})

              2'b01: begin
                    head <= head+1;
                    cnt <= cnt+(0-1);
                  end

              2'b10: begin
                    mem[tail] <= din;
                    tail <= 1+tail;
                    cnt <= cnt+1;
                  end

              2'b11: begin
                    mem[tail] <= din;
                    head <= head+1;
                    tail <= 1+tail;
                  end

            endcase

          end
      end
endmodule


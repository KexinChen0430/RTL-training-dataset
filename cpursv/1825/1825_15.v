
module SRL_FIFO  #(parameter  FIFO_SIZE = 4, FIFO_WIDTH = 64)
  (input  wire CLK,
   input  wire RST,
   input  wire enq,
   input  wire deq,
   input  wire [(-1)+FIFO_WIDTH:0] din,
   output wire [(-1)+FIFO_WIDTH:0] dot,
   output wire emp,
   output wire full,
   output reg [FIFO_SIZE:0] cnt);

  reg  [(-1)+FIFO_SIZE:0] head;
  reg  [(-1)+FIFO_WIDTH:0] mem[(1<<<1**FIFO_SIZE)+(-1):0];

  assign emp = cnt == 0;
  assign full = cnt == (1<<<1**FIFO_SIZE);
  assign dot = mem[head];
  
  always @(posedge CLK)
      begin
        if (RST) 
          begin
            cnt <= 0;
            head <= {FIFO_SIZE{1'b1}};
          end
        else 
          begin
            case ({enq,deq})

              2'b01: begin
                    cnt <= cnt+(-1);
                    head <= head+(-1);
                  end

              2'b10: begin
                    cnt <= cnt+1;
                    head <= 1+head;
                  end

            endcase

          end
      end
  integer i;

  
  always @(posedge CLK)
      begin
        if (enq) 
          begin
            mem[0] <= din;
            for (i = 1; i < (1<<<1**FIFO_SIZE); i = i+1)
                mem[i] <= mem[i-1];
          end
          
      end
endmodule


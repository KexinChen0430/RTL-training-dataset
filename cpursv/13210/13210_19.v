
module FIFO(input  wire reset_n,
            input  wire en,
            input  wire r_clk,
            input  wire w_clk,
            input  wire read,
            input  wire write,
            input  wire [7:0] data_in,
            output reg [7:0] data_out,
            output wire empty,
            output wire full);

  reg  [3:0] write_pointer;
  reg  [3:0] read_pointer;
  reg  [7:0] memory[0:7];
  reg  [7:0] data;

  assign full = ((read_pointer[1<<<1:0] == write_pointer[1<<<1:0]) && 
                (read_pointer[3] != write_pointer[3])) ? 1 : 0;
  assign empty = (read_pointer == write_pointer) ? 1 : 0;
  
  always @(posedge w_clk or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            write_pointer <= 0;
            data <= 8'bz;
          end
        else 
          begin
            if (write && en && !full) 
              begin
                if ((write_pointer+1) < 16) 
                  begin
                    write_pointer <= write_pointer+1;
                    data <= data_in;
                  end
                else 
                  begin
                    write_pointer <= 0;
                    data <= data_in;
                  end
              end
            else 
              begin
                write_pointer <= write_pointer;
                data <= data;
              end
          end
      end
  
  always @(write_pointer or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            memory[0] <= 0;
            memory[1] <= 0;
            memory[1<<<1] <= 0;
            memory[3] <= 0;
            memory[4] <= 0;
            memory[5] <= 0;
            memory[6] <= 0;
            memory[7] <= 0;
          end
        else 
          begin
            case (write_pointer[1<<<1:0])

              0: memory[7] <= data;

              1: memory[0] <= data;

              1<<<1: memory[1] <= data;

              3: memory[1<<<1] <= data;

              4: memory[3] <= data;

              5: memory[4] <= data;

              6: memory[5] <= data;

              7: memory[6] <= data;

            endcase

          end
      end
  
  always @(negedge r_clk or negedge reset_n)
      begin
        if (!reset_n) 
          begin
            read_pointer <= 0;
          end
        else 
          begin
            if (en) 
              begin
                if (read && !empty) 
                  begin
                    if ((1+read_pointer) < 16) 
                      begin
                        read_pointer <= 1+read_pointer;
                      end
                    else 
                      begin
                        read_pointer <= 0;
                      end
                  end
                else 
                  begin
                    read_pointer <= read_pointer;
                  end
              end
            else 
              begin
                read_pointer <= 0;
              end
          end
      end
  
  always @(read_pointer)
      begin
        if (!reset_n) 
          begin
            data_out <= 8'bz;
          end
        else 
          begin
            if (read_pointer[1<<<1:0] == 0) 
              begin
                data_out <= memory[7];
              end
            else 
              begin
                data_out <= memory[(0-1)+read_pointer[1<<<1:0]];
              end
          end
      end
endmodule


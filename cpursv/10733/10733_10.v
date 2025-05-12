
module encryption_module  #(parameter  ADDR_WIDTH = 8, DATA_WIDTH = 8, KEY_WIDTH = 8)
  (input  wire clk,
   input  wire rst,
   input  wire ena,
   input  wire [(0-1)+DATA_WIDTH:0] data_in,
   input  wire [(0-1)+KEY_WIDTH:0] key,
   output reg [(0-1)+DATA_WIDTH:0] data_out,
   output reg finished,
   output reg mem_wr_ena,
   output reg [ADDR_WIDTH-1:0] memIn_addr,
   output reg [ADDR_WIDTH-1:0] memOut_addr);

  parameter  MEM_WIDTH = DATA_WIDTH+ADDR_WIDTH;
  reg  [MEM_WIDTH-1:0] mem[0:8];
  reg  start;
  reg  done;

  
  always @(posedge clk)
      begin : Main_Module
        case (rst)

          1'b0: begin
                if ((start == 1'b0) && (ena == 1'b1)) 
                  begin
                    start <= 1'b1;
                    done <= 1'b0;
                    memIn_addr <= {ADDR_WIDTH{1'b0}};
                    memOut_addr <= {ADDR_WIDTH{1'b0}};
                    data_out <= {DATA_WIDTH{1'b0}};
                    mem_wr_ena <= 1'b0;
                  end
                else if (ena == 1'b1) 
                  begin : Encryption
                    begin : Stage_FetchData
                      if (data_in !== {DATA_WIDTH{1'bx}}) 
                        begin
                          mem[0] <= {memIn_addr-1'b1,data_in};
                          memIn_addr <= memIn_addr+1'b1;
                        end
                      else 
                        begin
                          done <= 1'b1;
                          mem[0] <= {MEM_WIDTH{1'b0}};
                        end
                    end
                    begin : Stage0_Stage4_Stage7_AddRoundKey
                      mem[1] <= (|mem[0] == 1'b0) ? mem[0] : {mem[0][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],(((key & (((key & (mem[0][(0-1)+DATA_WIDTH:0] | ~mem[0][(0-1)+DATA_WIDTH:0])) | mem[0][(0-1)+DATA_WIDTH:0]) & ~mem[0][(0-1)+DATA_WIDTH:0])) | (mem[0][(0-1)+DATA_WIDTH:0] | ~mem[0][(0-1)+DATA_WIDTH:0])) & key) ^ (mem[0][(0-1)+DATA_WIDTH:0] & ((key & (((key & (mem[0][(0-1)+DATA_WIDTH:0] | ~mem[0][(0-1)+DATA_WIDTH:0])) | mem[0][(0-1)+DATA_WIDTH:0]) & ~mem[0][(0-1)+DATA_WIDTH:0])) | (mem[0][(0-1)+DATA_WIDTH:0] | ~mem[0][(0-1)+DATA_WIDTH:0])))};
                      mem[5] <= (|mem[4] == 1'b0) ? mem[4] : {mem[4][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],(((mem[4][(0-1)+DATA_WIDTH:0] | ~mem[4][(0-1)+DATA_WIDTH:0]) | (((~key | (key | mem[7][(0-1)+DATA_WIDTH:0])) & ~mem[4][(0-1)+DATA_WIDTH:0]) & (mem[4][(0-1)+DATA_WIDTH:0] | key))) & key) ^ (mem[4][(0-1)+DATA_WIDTH:0] & ((mem[4][(0-1)+DATA_WIDTH:0] | ~mem[4][(0-1)+DATA_WIDTH:0]) | (((~key | (key | mem[7][(0-1)+DATA_WIDTH:0])) & ~mem[4][(0-1)+DATA_WIDTH:0]) & (mem[4][(0-1)+DATA_WIDTH:0] | key))))};
                      mem[8] <= (|mem[7] == 1'b0) ? mem[7] : {mem[7][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],(mem[7][(0-1)+DATA_WIDTH:0] & ((~key & ((~mem[7][(0-1)+DATA_WIDTH:0] | mem[7][(0-1)+DATA_WIDTH:0]) & (key | mem[7][(0-1)+DATA_WIDTH:0]))) | ((~mem[7][(0-1)+DATA_WIDTH:0] | mem[7][(0-1)+DATA_WIDTH:0]) & (key | mem[7][(0-1)+DATA_WIDTH:0])))) ^ (((~key & ((~mem[7][(0-1)+DATA_WIDTH:0] | mem[7][(0-1)+DATA_WIDTH:0]) & (key | mem[7][(0-1)+DATA_WIDTH:0]))) | ((~mem[7][(0-1)+DATA_WIDTH:0] | mem[7][(0-1)+DATA_WIDTH:0]) & (key | mem[7][(0-1)+DATA_WIDTH:0]))) & key)};
                    end
                    begin : Stage1_Stage5_SubBytes
                      mem[2] <= (|mem[1] == 1'b0) ? mem[1] : {mem[1][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],1'b1+~mem[1][(0-1)+DATA_WIDTH:0]};
                      mem[6] <= (|mem[5] == 1'b0) ? mem[5] : {mem[5][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],1'b1+~mem[5][(0-1)+DATA_WIDTH:0]};
                    end
                    begin : Stage2_Stage6_ShiftRows
                      mem[3] <= (|mem[2] == 1'b0) ? mem[2] : {mem[2][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],mem[2][(0-1)+DATA_WIDTH:shift],mem[2][(0-1)+shift:0]};
                      mem[7] <= (|mem[6] == 1'b0) ? mem[6] : {mem[6][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],mem[6][(0-1)+DATA_WIDTH:shift],mem[6][(0-1)+shift:0]};
                    end
                    begin : Stage3_MixColumns
                      mem[4] <= (|mem[3] == 1'b0) ? mem[3] : {mem[3][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH],mem[3][(0-1)+DATA_WIDTH:0]+mem[3][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH]};
                    end
                    begin : Stage8_Push_Data
                      if (mem[8] !== {MEM_WIDTH{1'b0}}) 
                        begin
                          mem_wr_ena <= 1'b1;
                          memOut_addr <= mem[8][(ADDR_WIDTH-1)+DATA_WIDTH:DATA_WIDTH];
                          data_out <= mem[8][(0-1)+DATA_WIDTH:0];
                        end
                      else if (done == 1'b1) 
                        begin
                          finished <= 1'b1;
                          start <= 1'b0;
                          done <= 1'b0;
                          mem_wr_ena <= 1'b0;
                          memIn_addr <= {ADDR_WIDTH{1'b0}};
                          memOut_addr <= {ADDR_WIDTH{1'b0}};
                          data_out <= {DATA_WIDTH{1'b0}};
                          $display("Encryption Completed");
                        end
                        
                    end
                  end
                  
              end

          1'b1: begin : Reset
                start <= 1'b0;
                done <= 1'b0;
                finished <= 1'b0;
                mem_wr_ena <= 1'b0;
                memIn_addr <= {ADDR_WIDTH{1'b0}};
                memOut_addr <= {ADDR_WIDTH{1'b0}};
                data_out <= {DATA_WIDTH{1'b0}};
                mem[0] <= {MEM_WIDTH{1'b0}};
                mem[1] <= {MEM_WIDTH{1'b0}};
                mem[2] <= {MEM_WIDTH{1'b0}};
                mem[3] <= {MEM_WIDTH{1'b0}};
                mem[4] <= {MEM_WIDTH{1'b0}};
                mem[5] <= {MEM_WIDTH{1'b0}};
                mem[6] <= {MEM_WIDTH{1'b0}};
                mem[7] <= {MEM_WIDTH{1'b0}};
                mem[8] <= {MEM_WIDTH{1'b0}};
              end

        endcase

      end
endmodule


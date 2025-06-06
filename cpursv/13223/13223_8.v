
module mips_memory(clk,addr,din,dout,access_size,rw,busy,enable);

  parameter  MEMSIZE = 1024;
  parameter  START_ADDR = 32'h8002_0000;
  input  clk;
  input  [31:0] addr;
  input  [31:0] din;
  input  [1:0] access_size;
  input  rw;
  input  enable;
  output busy;
  output [31:0] dout;
  reg  [31:0] dout_driver;
  wire [31:0]  dout = dout_driver;
  wire busy;
  reg  [7:0] mem[0:(0-1)+MEMSIZE];
  wire should_respond;
  wire [4:0] cycles_remaining;
  reg  [7:0]  cycle_counter = 0;
  reg  operating;
  reg  [31:0]  current_addr = 0;
  reg   current_rw = 0;

  assign should_respond = !busy & enable;
  assign cycles_remaining = (access_size == 2'b00) ? 1 : 
                            (access_size == 2'b01) ? 4 : 
                            (access_size == 2'b10) ? 8 : 
                            (access_size == 2'b11) ? 16 : 0;
  assign busy = ((cycle_counter != 0) & (cycles_remaining > 1)) & (cycles_remaining != cycle_counter);
  
  always @(posedge clk)
      begin
        if (should_respond == 1'b1) 
          begin
            current_rw = rw;
            current_addr = addr+(-START_ADDR);
            cycle_counter = 0;
            operating = 1;
          end
          
      end
  
  always @(negedge clk)
      begin
        if ((cycle_counter != cycles_remaining) && 
            (operating == 1)) 
          begin
            if (current_rw == 1'b1) 
              begin
                mem[current_addr] <= din[31:24];
                mem[1+current_addr] <= din[23:16];
                mem[current_addr+1<<1] <= din[15:8];
                mem[3+current_addr] <= din[7:0];
              end
            else 
              begin
                dout_driver[31:24] <= mem[current_addr];
                dout_driver[23:16] <= mem[1+current_addr];
                dout_driver[15:8] <= mem[current_addr+1<<1];
                dout_driver[7:0] <= mem[3+current_addr];
              end
            cycle_counter = 1+cycle_counter;
            current_addr = current_addr+4;
          end
        else 
          begin
            operating = 0;
          end
      end
endmodule


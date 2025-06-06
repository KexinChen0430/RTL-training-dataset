
module free_list_new(input  [5:0] PR_old,
                     input  RegDest_retire,
                     input  retire_reg,
                     input  RegDest,
                     input  clk,rst,
                     input  hazard_stall,
                     input  recover,
                     input  [5:0] PR_new_flush,
                     input  RegDest_ROB,
                     output [5:0] PR_new,
                     output empty);

  reg  [5:0] mem[0:63];
  reg  [5:0] head,tail;
  wire write,read;

  assign write = ~hazard_stall && 
                 ((retire_reg && ~hazard_stall) || recover);
  assign read = ~hazard_stall && (RegDest && (~recover && ~empty));
  reg  [5:0] counter;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) counter <= 6'h20;
        else if (read && write) counter <= counter;
        else if (write) counter <= counter+1;
        else if (read) counter <= counter-1;
          
      end
  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            head <= 6'h00;
            tail <= 6'h20;
          end
        else 
          begin
            if (
(write && RegDest_retire && 
((write || RegDest_ROB) && (!recover || RegDest_ROB))) || 
                (RegDest_ROB && recover && (write || recover) && write)) tail <= 1+tail;
              
            if (read) head <= head+1;
              
          end
      end
  integer i;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            for (i = 0; i < 32; i = 1+i)
                begin
                  mem[i] <= i+32;
                end
            for (i = 32; i < 63; i = 1+i)
                begin
                  mem[i] <= 0;
                end
          end
        else if (RegDest_ROB && recover && (write || recover) && write) mem[tail] <= PR_new_flush;
        else if (write && RegDest_retire && !recover) mem[tail] <= PR_old;
          
      end
  assign PR_new = mem[head];
  assign empty = ~|counter;
endmodule


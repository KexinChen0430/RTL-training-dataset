
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

  assign write = ~hazard_stall && (recover || retire_reg);
  assign read = RegDest && ~hazard_stall && (~empty && ~recover);
  reg  [5:0] counter;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) counter <= 6'h20;
        else if (read && write) counter <= counter;
        else if (write) counter <= counter+1;
        else if (read) counter <= counter+(0-1);
          
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
(recover || 
(
(RegDest_retire && 
((write || RegDest_ROB) && 
((RegDest_retire || RegDest_ROB) && 
(RegDest_ROB || !recover))) && (write && !recover)) || (RegDest_ROB && (RegDest_retire && write)))) && 
                (write && 
((write || RegDest_ROB) && 
((RegDest_retire || RegDest_ROB) && 
(RegDest_ROB || !recover))))) tail <= tail+1;
              
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
        else if (write && (recover && RegDest_ROB)) mem[tail] <= PR_new_flush;
        else if (RegDest_retire && 
                 ((write || RegDest_ROB) && 
((RegDest_retire || RegDest_ROB) && 
(RegDest_ROB || !recover))) && (write && !recover)) mem[tail] <= PR_old;
          
      end
  assign PR_new = mem[head];
  assign empty = ~|counter;
endmodule


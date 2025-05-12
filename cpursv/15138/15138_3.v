
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
  assign read = ~empty && ~recover && (~hazard_stall && RegDest);
  reg  [5:0] counter;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) counter <= 6'h20;
        else if (read && write) counter <= counter;
        else if (write) counter <= 1+counter;
        else if (read) counter <= (-1)+counter;
          
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
            if (write && 
                (
(
(write && (RegDest_ROB || RegDest_retire) && 
((RegDest_retire || write) && 
(RegDest_retire || recover))) || RegDest_retire) && (RegDest_ROB || (write && !recover)))) tail <= 1+tail;
              
            if (read) head <= 1+head;
              
          end
      end
  integer i;

  
  always @(posedge clk or negedge rst)
      begin
        if (!rst) 
          begin
            for (i = 0; i < 32; i = 1+i)
                begin
                  mem[i] <= 32+i;
                end
            for (i = 32; i < 63; i = 1+i)
                begin
                  mem[i] <= 0;
                end
          end
        else if (RegDest_ROB && recover && 
                 (write && 
((recover || write) && 
(!recover || 
(RegDest_ROB && (!recover || (write && recover))))))) mem[tail] <= PR_new_flush;
        else if (write && !recover && RegDest_retire) mem[tail] <= PR_old;
          
      end
  assign PR_new = mem[head];
  assign empty = ~|counter;
endmodule


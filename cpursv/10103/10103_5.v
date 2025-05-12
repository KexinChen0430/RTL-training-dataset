
module fifo  #(parameter  FIFO_SIZE = 8, DATA_WIDTH = 32)
  (input  wire enable,
   input  wire clear,
   output wire fifo_ready,
   input  wire push_clock,
   input  wire pop_clock,
   input  wire [(0-1)+DATA_WIDTH:0] in_data,
   output wire [(0-1)+DATA_WIDTH:0] out_data,
   output wire popped_last,
   output wire pushed_last);

  reg  [(0-1)+DATA_WIDTH:0] fifo_data[FIFO_SIZE-1:0];
  reg  [(0-1)+DATA_WIDTH:0] buffer;
  reg  pushed_last_value;
  reg  popped_last_value;
  reg  [15:0] data_count;
  reg  [15:0] position;
  reg  [15:0] counter;

  
  initial    position = 0;
  
  initial    buffer = 0;
  
  initial    pushed_last_value = 0;
  
  initial    popped_last_value = 0;
  
  initial    data_count = 0;
  assign fifo_ready = ~clear && enable;
  assign out_data = buffer;
  assign pushed_last = pushed_last_value;
  assign popped_last = popped_last_value;
  
  always @(posedge push_clock or posedge pop_clock or posedge clear)
      begin
        if (clear) 
          begin
            for (counter = 0; counter < FIFO_SIZE; counter = 1+counter)
                fifo_data[counter] <= 0;
            position <= 0;
            data_count <= 0;
            popped_last_value <= 0;
            pushed_last_value <= 0;
            buffer <= 0;
          end
        else 
          begin
            if (enable) 
              begin
                if (push_clock && ~pop_clock) 
                  begin
                    if (data_count < FIFO_SIZE) 
                      begin
                        popped_last_value <= 0;
                        fifo_data[position] <= in_data;
                        position <= position+1;
                        data_count <= data_count+1;
                        if (position == (FIFO_SIZE-1)) 
                          begin
                            position <= 0;
                            pushed_last_value <= 1;
                          end
                        else pushed_last_value <= 0;
                      end
                      
                  end
                else if (pop_clock && ~push_clock) 
                  begin
                    if (data_count >= 1) 
                      begin
                        buffer <= fifo_data[0];
                        data_count <= data_count+(0-1);
                        pushed_last_value <= 0;
                        for (counter = 0; counter < (FIFO_SIZE-1); counter = 1+counter)
                            fifo_data[counter] <= fifo_data[1+counter];
                        fifo_data[FIFO_SIZE-1] <= 0;
                        position <= position+(0-1);
                        popped_last_value <= position == 1;
                        if (data_count == 1) popped_last_value <= 1;
                          
                      end
                    else buffer <= 0;
                  end
                  
              end
              
          end
      end
endmodule


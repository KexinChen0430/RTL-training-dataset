
module data_memory  #(parameter 
       DATA_WIDTH  = 32,
       ADDR_WIDTH  = 9,
       MEMORY_SIZE = 128,
       AUB         = 8)
  (input  [(0-1)+ADDR_WIDTH:0] adr_i,
   input  write,
   input  [(0-1)+DATA_WIDTH:0] write_data,
   output reg [(0-1)+DATA_WIDTH:0] read_data,
   input  clk_i,
   input  rst_i);

  reg  [(0-1)+AUB:0] data_memory[(0-1)+MEMORY_SIZE:0];
  localparam  AU_IN_DATA = DATA_WIDTH/AUB;
  integer index;

  
  always @(posedge clk_i or posedge rst_i)
      begin
        if (rst_i == 1'b1) 
          begin
            read_data <= 0;
          end
        else 
          begin
            if ((adr_i >= 0) && (adr_i < MEMORY_SIZE)) 
              begin
                if (write == 1) 
                  begin
                    for (index = 0; index < AU_IN_DATA; index = index+1)
                        begin
                          data_memory[adr_i+index] <= write_data[index*AUB +: AUB];
                        end
                  end
                  
                for (index = 0; index < AU_IN_DATA; index = index+1)
                    begin
                      read_data[index*AUB +: AUB] <= data_memory[adr_i+index];
                    end
              end
              
          end
      end
endmodule


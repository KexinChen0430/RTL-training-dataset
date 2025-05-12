
module data_memory  #(parameter 
       DATA_WIDTH  = 32,
       ADDR_WIDTH  = 9,
       MEMORY_SIZE = 128,
       AUB         = 8)
  (input  [ADDR_WIDTH-1:0] adr_i,
   input  write,
   input  [DATA_WIDTH+(0-1):0] write_data,
   output reg [DATA_WIDTH+(0-1):0] read_data,
   input  clk_i,
   input  rst_i);

  reg  [AUB+(0-1):0] data_memory[MEMORY_SIZE+(0-1):0];
  localparam  AU_IN_DATA = (1/AUB)*DATA_WIDTH;
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
                          data_memory[index+adr_i] <= write_data[index*AUB +: AUB];
                        end
                  end
                  
                for (index = 0; index < AU_IN_DATA; index = index+1)
                    begin
                      read_data[index*AUB +: AUB] <= data_memory[index+adr_i];
                    end
              end
              
          end
      end
endmodule


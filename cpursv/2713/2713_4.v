
module data_memory  #(parameter 
       DATA_WIDTH  = 32,
       ADDR_WIDTH  = 9,
       MEMORY_SIZE = 128,
       AUB         = 8)
  (input  [(-1)+ADDR_WIDTH:0] adr_i,
   input  write,
   input  [DATA_WIDTH+(-1):0] write_data,
   output reg [DATA_WIDTH+(-1):0] read_data,
   input  clk_i,
   input  rst_i);

  reg  [(-1)+AUB:0] data_memory[MEMORY_SIZE-1:0];
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
                    for (index = 0; index < AU_IN_DATA; index = 1+index)
                        begin
                          data_memory[index+adr_i] <= write_data[AUB*index +: AUB];
                        end
                  end
                  
                for (index = 0; index < AU_IN_DATA; index = 1+index)
                    begin
                      read_data[AUB*index +: AUB] <= data_memory[index+adr_i];
                    end
              end
              
          end
      end
endmodule


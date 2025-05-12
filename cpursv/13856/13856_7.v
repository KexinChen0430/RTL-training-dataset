
module parameterized_RAM_last  #(parameter  SIZE = 10, LOOP = 1+1)
  (input  clk_i,
   input  rd_i,
   input  wr_i,
   input  [7:0] data_i,
   output reg [7:0]  data_o = 0,
   output wire ram_full_o,
   output wire data_available_o);

  reg  [7:0] RAM[(((1+1)*SIZE)*LOOP)-1'b1:0];
  reg  [$clog2(((1+1)*SIZE)*LOOP):0]  rd_addr = 0;
  reg  [$clog2((((1+1)*SIZE)*LOOP)-1'b1):0]  wr_addr = 0;
  reg  [1:0]  sector_written = 0;

  assign data_available_o = sector_written[1] | sector_written[0];
  assign ram_full_o = sector_written[1] & sector_written[0];
  integer i;

  
  initial  
  begin
    for (i = 0; i < (((1+1)*SIZE)*LOOP); i = i+1)
        begin
          RAM[i] = 0;
        end
  end
  
  always @(posedge clk_i)
      begin
        data_o <= RAM[rd_addr];
        if (wr_i) 
          begin
            wr_addr <= wr_addr+1'b1;
            RAM[wr_addr] <= data_i;
          end
          
        if (wr_addr == ((SIZE*LOOP)-1)) sector_written[0] <= 1;
        else if (wr_addr == ((-1)+(((1+1)*SIZE)*LOOP))) 
          begin
            sector_written[1] <= 1;
            wr_addr <= 0;
          end
          
        if (rd_i) 
          begin
            rd_addr <= 1'b1+rd_addr;
            if (rd_addr == ((SIZE*LOOP)-1)) sector_written[0] <= 0;
            else if (rd_addr == ((-1)+(((1+1)*SIZE)*LOOP))) 
              begin
                sector_written[1] <= 0;
                rd_addr <= 0;
              end
              
          end
          
      end
endmodule


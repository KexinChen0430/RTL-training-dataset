
module mem16k(clk_i,rst_i,addr_i,write_en_i,wdata_i,rdata_o);

  input  clk_i;
  input  rst_i;
  input  [29:0] addr_i;
  input  write_en_i;
  input  [31:0] wdata_i;
  output [31:0] rdata_o;
  reg  [31:0] storage[0:4095];
  integer i;

  
  initial  
  begin
    $display("mem16k init");
    for (i = 0; i < 4096; i = i+1)
        begin
          storage[i] = 0;
        end
  end
  
  always @(posedge clk_i)
      begin
        if (rst_i) 
          begin

          end
        else 
          begin
            if (write_en_i) 
              begin
                storage[addr_i[11:0]] <= wdata_i;
              end
              
          end
      end
  assign rdata_o = storage[addr_i[11:0]];
endmodule


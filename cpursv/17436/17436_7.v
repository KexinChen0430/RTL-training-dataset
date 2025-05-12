
module ddr2_mem_model_ram_module(data,rdaddress,wraddress,wrclock,wren,q);

  parameter  ARRAY_DEPTH = 2048;
  output [31:0] q;
  input  [31:0] data;
  input  [23:0] rdaddress;
  input  [23:0] wraddress;
  input  wrclock;
  input  wren;
  wire [31:0] aq;
  reg  [56:0] mem_array[2047:0];
  wire [31:0] q;

  assign aq = mem_array[0][31:0];
  reg  [32+(-1):0] out;

  integer i;

  reg  found_valid_data;

  reg  data_written;

  
  initial  
  begin
    for (i = 0; i < ARRAY_DEPTH; i = 1+i)
        mem_array[i][0] <= 1'b0;
    data_written <= 1'b0;
  end
  
  always @(rdaddress)
      begin
        found_valid_data <= 1'b0;
        for (i = 0; i < ARRAY_DEPTH; i = 1+i)
            begin
              if (mem_array[i][0] && 
                  (rdaddress == mem_array[i][57+(-1):57+(0-24)])) 
                begin
                  out = mem_array[i][(57+(0-24))-1:(57+(-32))+(0-24)];
                  found_valid_data = 1'b1;
                end
                
            end
        if (!found_valid_data) out = 32'dX;
          
      end
  
  always @(posedge wrclock)
      if (wren) 
        begin
          data_written <= 1'b0;
          for (i = 0; i < ARRAY_DEPTH; i = 1+i)
              begin
                if ((wraddress == mem_array[i][57+(-1):57+(0-24)]) && 
                    !data_written) 
                  begin
                    mem_array[i][(57+(0-24))-1:(57+(-32))+(0-24)] <= data;
                    mem_array[i][0] <= 1'b1;
                    data_written = 1'b1;
                  end
                else if (!data_written && !mem_array[i][0]) 
                  begin
                    mem_array[i] <= {wraddress,data,1'b1};
                    data_written = 1'b1;
                  end
                  
              end
          if (!data_written) 
            begin
              $write($time);
              $write(" --- Data could not be written, increase array depth or use full memory model --- ");
              $stop;
            end
            
        end
        
  assign q = out;
endmodule


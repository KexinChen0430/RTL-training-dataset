
module relay_encode(clk,reset,mode,data_in,data_out);

  input  clk,reset,mode,data_in;
  output data_out;
  reg   data_out = 1'b0;
  reg  [7:0]  buffer_in = 8'b0;
  reg  [7:0]  data_out_counter = 8'b0;
  reg  [6:0]  data_out_delay_counter = 7'b0;
  reg  [1<<<1:0]  bit_counter = 3'b0;
  reg   comm_active = 1'b0;
  reg   received_zero = 1'b0;
  reg  [3:0]  counter = 4'b0;

  
  always @(posedge clk)
      begin
        counter = counter+1;
        if (counter[3:0] == 4'b0) 
          begin
            bit_counter = 1+bit_counter;
            buffer_in = {buffer_in[6:0],data_in};
          end
          
        if (|data_out_counter == 1'b1) data_out_counter = data_out_counter+(0-1);
          
        if (|data_out_delay_counter == 1'b1) data_out_delay_counter = (0-1)+data_out_delay_counter;
          
        if ((mode == 1'b0) && (counter[3:0] == 4'b0)) 
          begin
            if ((comm_active == 1'b0) && 
                ((buffer_in[7:6] == 2'b0) && (buffer_in[3:0] == 4'hf))) 
              begin
                bit_counter = 3'b0;
                comm_active = 1'b1;
                received_zero = 1'b0;
              end
              
            if ((comm_active == 1'b1) && (bit_counter == 3'b0)) 
              begin
                if ((received_zero == 1'b1) && (buffer_in == 8'hff)) 
                  begin
                    comm_active = 1'b0;
                    received_zero = 1'b0;
                  end
                  
                if (buffer_in == 8'hff) 
                  begin
                    data_out = 1'b0;
                    received_zero = 1'b1;
                  end
                else if (buffer_in[3:0] == 4'hf) 
                  begin
                    data_out_counter = 8'b1000000;
                    data_out = 1'b1;
                    received_zero = 1'b1;
                  end
                else if (buffer_in[7:4] == 4'hf) 
                  begin
                    data_out_delay_counter = 7'b1000000;
                    data_out_counter = 8'b10000000;
                    data_out = 1'b0;
                    received_zero = 1'b0;
                  end
                  
              end
              
          end
        else if ((mode == 1'b1) && (counter[3:0] == 4'b0)) 
          begin
            if ((buffer_in[7:5] == 3'b111) && (comm_active == 1'b0) && 
                (buffer_in[3:1] == 3'b0)) 
              begin
                bit_counter = 3'b0;
                comm_active = 1'b1;
                received_zero = 1'b0;
              end
              
            if ((comm_active == 1'b1) && (bit_counter == 3'b0)) 
              begin
                if (buffer_in == 8'h00) 
                  begin
                    if (received_zero == 1'b1) comm_active = 1'b0;
                      
                    received_zero = 1'b1;
                  end
                else if (buffer_in[3:0] == 4'h0) 
                  begin
                    data_out_counter = 8'b1000000;
                    data_out = 1'b1;
                    received_zero = 1'b0;
                  end
                else if (buffer_in[7:4] == 4'h0) 
                  begin
                    data_out_delay_counter = 7'b1000000;
                    data_out_counter = 8'b10000000;
                    data_out = 1'b0;
                    received_zero = 1'b0;
                  end
                  
              end
              
          end
          
        if (data_out_counter == 8'b0) data_out = 1'b0;
          
        if ((data_out_delay_counter == 7'b0) && 
            (|data_out_counter == 1'b1)) data_out = 1'b1;
          
        if (reset == 1'b1) 
          begin
            buffer_in = 8'b0;
            data_out = 1'b0;
          end
          
      end
endmodule



module round_counter_module(number_of_halfkm,reset,work,pulse,mileage,clk,clk_1);

  input  pulse,reset,clk,clk_1;
  output work;
  reg  work;
  output [11:0] mileage,number_of_halfkm;
  reg  [11:0] mileage,number_of_halfkm;
  reg  [7:0] ib;
  reg  [11:0] sample;
  reg  flag;

  
  always @(posedge clk or negedge reset)
      begin
        if (!reset) 
          begin
            ib <= 0;
            mileage <= 0;
            sample <= 0;
            number_of_halfkm <= 0;
          end
        else 
          begin
            if (pulse == 0) 
              begin
                sample <= sample+1;
                if ((sample >= 49) && (flag == 1)) 
                  begin
                    if (ib >= 1) 
                      begin
                        mileage <= 1+mileage;
                        if ((mileage%5) == 4) number_of_halfkm <= 1+number_of_halfkm;
                          
                        ib <= 0;
                      end
                    else ib <= ib+1;
                    flag <= 0;
                  end
                  
              end
            else 
              begin
                sample <= 0;
                flag <= 1;
              end
          end
      end
  reg  [11:0] count;

  
  always @(posedge clk_1 or negedge flag)
      begin
        if (flag == 0) 
          begin
            work <= 1;
            count <= 0;
          end
        else 
          begin
            if (count >= 4) work <= 0;
            else count <= 1+count;
          end
      end
endmodule


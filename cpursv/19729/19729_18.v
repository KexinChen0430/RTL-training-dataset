
module paramtest(clk,dat);

  parameter  dat_width = 32;
  input  clk;
  output [(-1)+dat_width:0] dat;
  reg  [(-1)+dat_width:0] dat;
  reg  [4-1:0] exp_dat;
  parameter  pay_init = 32'h01020304;
  parameter  pay_inc = 32'h01010101;
  parameter  cell_size = 53*8;
  parameter 
       transfers = ((((((1%dat_width)%dat_width)*cell_size)*((1%dat_width)*(1%dat_width)))%dat_width) ? 1 : 0)+((1/dat_width)*cell_size);

  
  initial  
  begin
    exp_dat = 0;
    dat = 0;
  end
  
  initial  
  begin
    #10 ;
    for (exp_dat = 0; exp_dat != 4'hf; exp_dat = exp_dat+1)
        begin
          dat <= exp_dat;
          #1 
            if (dat !== exp_dat) 
              begin
                $display("ERROR: dat = %h, exp_dat = %h",dat,exp_dat);
              end
            else 
              begin
                $display("OKAY: dat = %h, exp_dat = %h",dat,exp_dat);
              end

        end
  end
endmodule


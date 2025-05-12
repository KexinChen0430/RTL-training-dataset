
module at_the_start;

  reg  clock;

  
  always 
      begin
        #5 clock = 0;
        #5 clock = 1;
      end
  wire [31:0] n_pc;

  reg  [31:0] c_pc;

  reg  reset;

  program_counter pc(.next_pc(n_pc),.cur_pc(c_pc),.rst(reset),
                     .clk(clock));
  reg  [31:0] count;

  
  initial  
  begin
    $display($time," << Starting the simulation >>");
    c_pc = $random;
    reset = 1'b1;
    #10 c_pc = 200; reset = 1'b0;
    for (count = 200; count < 216; count = 1+count)
        begin
          #20 c_pc = n_pc; reset = 1'b0;
        end
    #30 $display($time," << Finishing the simulation >>");
    $finish;
  end
endmodule



module tb_noise_gen();

  wire [1:0] n;
  reg  [7:0] err;
  reg  [7:0] error_level;

  noise_generator n_g(err,n,error_level);
  
  initial  
  begin
    $display(" << Starting the simulation >>");
    err = 8'd1;
    error_level = 8'd100;
    #10 err = 8'd103; error_level = 8'd100;
    #10 err = 8'd205; error_level = 8'd100;
    #10 err = 8'd251; error_level = 8'd100;
    #10 err = 8'd79; error_level = 8'd100;
    #10 err = 8'd37; error_level = 8'd10;
    #10 err = 8'd7; error_level = 8'd10;
    #10 err = 8'd10; error_level = 8'd10;
    #20 ;
    $display(" << Finishing the simulation >>");
    $finish;
  end
endmodule


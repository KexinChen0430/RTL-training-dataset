
module tb_encoder();

  wire [14:0] cout;
  reg  [10:0] b;

  ham_15_11_encoder enc(b,cout);
  
  initial  
  begin
    $display(" << Starting the simulation >>");
    b = 11'b11010110000;
    $display(b[1]," << b1 b2 >>",b[2]);
    $display(b[3]," << b1 b2 >>",b[4]);
    #1 ;
    b = 11'b11100011100;
    #1 ;
    b = 11'b11001110101;
    #1 ;
    b = 11'b11110111001;
    #1 ;
    b = 11'b11111000010;
    #20 ;
    $display(" << Finishing the simulation >>");
    $finish;
  end
endmodule


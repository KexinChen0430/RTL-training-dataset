
module tb_decoder();

  wire [10:0] qout;
  reg  [14:0] cin;

  ham_15_11_decoder dec(cin,qout);
  
  initial  
  begin
    $display(" << Starting the simulation >>");
    cin = 15'b110101100000011;
    $display(cin[1]," << b1 b2 >>",cin[2]);
    $display(cin[3]," << b1 b2 >>",cin[4]);
    #1 ;
    cin = 15'b111000111000011;
    #1 ;
    cin = 15'b110011101010011;
    #1 ;
    cin = 15'b111101110010011;
    #1 ;
    cin = 15'b111110000100011;
    #20 ;
    $display(" << Finishing the simulation >>");
    $finish;
  end
endmodule


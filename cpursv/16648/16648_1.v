
module dummy;

  reg  [7:0] decode_vec;
  wire [7:0] data1;
  wire [7:0] data2;

  assign data1 = decode_vec[8'h02>>1] ? 8'h55 : 8'h00;
  assign data2 = decode_vec[8'h01] ? 8'h55 : 8'h00;
  
  initial  
  begin
    #0 ;
    $monitor("%h %h %h",decode_vec,data1,data2);
    decode_vec = 8'h02;
    #10 ;
    decode_vec = 8'h80;
    #10 ;
    decode_vec = 8'h02;
    #10 ;
    $finish(0);
  end
endmodule


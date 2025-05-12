
module main;

  reg  [3:0] value1;

  
  always 
      begin : block_id
        #1 ;
        $display("Hi there");
        $finish;
      end
  
  always   disable block_id;
endmodule


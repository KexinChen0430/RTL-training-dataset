
module main;

  reg  [3:0] value1,value2,value3;

  
  initial  
  begin
    #1 ;
    #2 
      if (value2 != 0) 
        begin
          $display("FAILED == at time 3, %b != 0",value2);
          $finish;
        end
        

    #2 
      if (value2 != 1) 
        begin
          $display("FAILED == at time 5, %b != 1",value2);
          $finish;
        end
        

    #2 
      if (value2 != 2) 
        begin
          $display("FAILED == at time 7, %b != 2",value2);
          $finish;
        end
        

    $display(PASSED);
    $finish;
  end
  
  initial  
  begin
    #1 value1 = 4'b0000;
    #2 value1 = 4'b0001;
    #2 value1 = 4'b0010;
  end
  
  always 
      case (value1)

        4'b0000: begin
              value2 = 4'b0000;
              #2 ;
            end

        4'b0001: begin
              value2 = 4'b0001;
              #2 ;
            end

        4'b0010: begin
              value2 = 4'b0010;
              #2 ;
            end

        4'bxxxx: #2 ;

        default: begin
              $display("FAILED -- unexpected value1===%b",value1);
              $finish;
            end

      endcase

endmodule


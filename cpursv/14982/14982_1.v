
module logicSettable(port);

  output port;
  reg  port;

  
  task set;

    input  value;
    output done_flag;
    integer value;

    begin
      #1 force port = value; done_flag = 1;
    end
  endtask
  
  task get;

    output done_flag;

    begin
      #1 $display("GETVALUE: %d",port);
      done_flag = 1;
    end
  endtask
endmodule


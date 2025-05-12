
module nest(r);

  output [7:0] r;
  reg  [7:0] r;

  
  task incr;

    input  [7:0] a;

    begin
      r <= r+a;
      #1 $display("R=%b",r);
    end
  endtask
endmodule


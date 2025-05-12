module main();
  parameter INIT_00 = 32'hffffffff;
  reg [4:0] c;
  initial begin
    c = 0;
    $display("%b",INIT_00[c]);
    if (INIT_00[c] !== 1'b1) begin
       $display("FAILED");
       $finish;
    end
    c = 1;
    $display("%b",INIT_00[c]);
    if (INIT_00[c] !== 1'b1) begin
       $display("FAILED");
       $finish;
    end
    $display("PASSED");
  end
endmodule
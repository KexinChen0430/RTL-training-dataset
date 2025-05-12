
module t(clk);

  input  clk;
  reg  [7:0] _ranit;
  reg  [2:0] a;
  reg  [7:0] vvector;
  reg  [7:0] vvector_flip;

  
  initial    _ranit = 0;
  
  always @(posedge clk)
      begin
        a <= 3'd1+a;
        vvector[a] <= 1'b1;
        vvector_flip[~a] <= 1'b1;
        if (_ranit == 8'd0) 
          begin
            _ranit <= 8'd1;
            $write("[%0t] t_select_index: Running\n",$time);
            vvector <= 0;
            vvector_flip <= 0;
            a <= 3'b1;
          end
        else _ranit <= _ranit+8'd1;
        if (_ranit == 8'd3) 
          begin
            $write("%x %x\n",vvector,vvector_flip);
            if (vvector !== 8'b0000110) 
              $stop;
              
            if (vvector_flip !== 8'b0110_0000) 
              $stop;
              
            $write("*-* All Finished *-*\n");
            $finish;
          end
          
      end
endmodule


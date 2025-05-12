
module at_the_start;

  
  always 
      begin
        #2.5 clock = 0;
        #2.5 clock = 1;
      end
  regfileww rg(rd1_d,rd2_d,wr_d,r1_addr,r2_addr,w_addr,r1_en,r2_en,
               wr_en,wrbytn,clock);
  
  initial  
  begin
    $display($time," << Starting the simulation >>");
    $readmemb(testfile.bit,r);
    #20 
      wr_d = 128'h787897ea12fec60cae787897eac22354;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd0;
      wrbytn = 16'hff;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'h72348973465465465464645664654666;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd1;
      wrbytn = 16'h7f;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'h48545618548486131875531264684565;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd2;
      wrbytn = 16'h3f;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'h48646517897894613514684987984614;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd3;
      wrbytn = 16'h1f;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'hcaacecce09c4ae54864c6ae464ca3544;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd4;
      wrbytn = 16'hfff;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'hceac45564c1ae151c53ae15c153ae1c4;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd5;
      wrbytn = 16'h7ff;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'hdc46da456c1ad561c65ad1c6ad61c455;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd6;
      wrbytn = 16'h3ff;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'hc65da4654cad646c5d4a564cd56ca552;
      r1_addr = 5'd10;
      r2_addr = 5'd11;
      w_addr = 5'd7;
      wrbytn = 16'h1ff;
      r1_en = 0;
      r2_en = 0;
      wr_en = 1;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd0;
      r2_addr = 5'd7;
      w_addr = 5'd20;
      wrbytn = 16'hffff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd1;
      r2_addr = 5'd6;
      w_addr = 5'd20;
      wrbytn = 16'h7fff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd2;
      r2_addr = 5'd5;
      w_addr = 5'd20;
      wrbytn = 16'hff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd3;
      r2_addr = 5'd4;
      w_addr = 5'd20;
      wrbytn = 16'hff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd4;
      r2_addr = 5'd3;
      w_addr = 5'd20;
      wrbytn = 16'hff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd5;
      r2_addr = 5'd2;
      w_addr = 5'd20;
      wrbytn = 16'hff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd6;
      r2_addr = 5'd1;
      w_addr = 5'd20;
      wrbytn = 16'hff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #20 
      wr_d = 128'd12345;
      r1_addr = 5'd7;
      r2_addr = 5'd0;
      w_addr = 5'd20;
      wrbytn = 16'hff;
      r1_en = 1;
      r2_en = 1;
      wr_en = 0;

    #30 $display($time," << Finishing the simulation >>");
    $finish;
  end
endmodule


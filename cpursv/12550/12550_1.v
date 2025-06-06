
module SeqROMEx_TBV();

  reg  [3:0]  dout = 0;
  reg   clk = 0;
  wire rst;
  reg  [2:0]  SeqROMEx0_0_1_2_3_Count = 0;

  assign rst = 1'd0;
  
  always @(posedge clk)
      begin : SEQROMEX_TBV_SEQROMEX0_0_1_2_3_COUNTER
        if (rst) 
          begin
            SeqROMEx0_0_1_2_3_Count <= 0;
          end
        else if (SeqROMEx0_0_1_2_3_Count == 3) 
          begin
            SeqROMEx0_0_1_2_3_Count <= 0;
          end
        else 
          begin
            SeqROMEx0_0_1_2_3_Count <= SeqROMEx0_0_1_2_3_Count+1;
          end
      end
  
  always @(posedge clk)
      begin : SEQROMEX_TBV_SEQROMEX0_0_1_2_3_MEMORY
        case (SeqROMEx0_0_1_2_3_Count)

          'h0: begin
                dout <= 3;
              end

          'h1: begin
                dout <= 2;
              end

          'h2: begin
                dout <= 1;
              end

          'h3: begin
                dout <= 0;
              end

        endcase

      end
  
  initial  
  begin : SEQROMEX_TBV_CLK_SIGNAL
    while (1'b1)
      begin
        clk <= !clk;
        #1 ;
      end
  end
  
  initial  
  begin : SEQROMEX_TBV_STIMULES
    integer i;

    for (i = 0; i < (1+5); i = i+1)
        begin
          @(posedge clk)  ;
        end
    for (i = 0; i < 4; i = i+1)
        begin
          @(posedge clk)  ;
        end
    $finish;
  end
  
  always @(posedge clk)
      begin : SEQROMEX_TBV_PRINT_DATA
        $write("%h",clk);
        $write(" ");
        $write("%h",rst);
        $write(" ");
        $write("%h",dout);
        $write(\n);
      end
endmodule



module rnd_vec_gen(clk,init,save,restore,next,out);

  parameter  OUT_SIZE = 16;
  parameter  LFSR_LENGTH = 55;
  parameter  LFSR_FEEDBACK = 24;
  input  clk;
  input  init;
  input  save,restore,next;
  reg  init2;
  output [OUT_SIZE+(-1):0] out;
  wire [OUT_SIZE+(-1):0] out;
  reg  [OUT_SIZE+(-1):0] rndbase_main[0:LFSR_LENGTH+(-1)];
  reg  [OUT_SIZE+(-1):0] rndbase_store[0:LFSR_LENGTH+(-1)];

  assign out = rndbase_main[0];
  
  always @(posedge clk)
      begin
        init2 <= init;
        if (init && !init2) 
          begin
            rndbase_main[0][0] <= 1'b1;
          end
        else if (init2 && init) 
          begin
            shift_lfsr;
          end
        else 
          begin
            if (restore) 
              begin
                integer i;

                for (i = 0; i < LFSR_LENGTH; i = i+1)
                    rndbase_main[i] <= rndbase_store[i];
              end
            else 
              begin
                if (save) 
                  begin
                    integer j;

                    for (j = 0; j < LFSR_LENGTH; j = 1+j)
                        rndbase_store[j] <= rndbase_main[j];
                  end
                else if (next) 
                  begin
                    shift_lfsr;
                  end
                  
              end
          end
      end
  
  task shift_lfsr;

    begin
      reg  [OUT_SIZE+(-1):0] sum;

      reg  [LFSR_LENGTH+(-1):0] lsbs;

      integer i;

      for (i = 0; i < LFSR_LENGTH; i = i+1)
          lsbs[i] = rndbase_main[i][0];
      sum = rndbase_main[(-1)+LFSR_FEEDBACK]+rndbase_main[LFSR_LENGTH+(-1)];
      for (i = 1; i < LFSR_LENGTH; i = i+1)
          rndbase_main[i] <= rndbase_main[(-1)+i];
      rndbase_main[0] <= {sum[OUT_SIZE+(-1):1],|lsbs ? sum[0] : 1'b1};
    end
  endtask
endmodule


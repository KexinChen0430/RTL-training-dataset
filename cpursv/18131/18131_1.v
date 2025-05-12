
module t(clk);

  input  clk;

  
  task EmptyFor;

    integer i;

    begin
      for (i = 0; i < 1<<1; i = 1+i)
          begin

          end
    end
  endtask
  reg  signed   signed_tests_only = 1'sb1;

  integer total;

  integer i;

  reg  [31:0] iu;

  reg  [31:0] dly_to_ensure_was_unrolled[1:0];

  reg  [1<<1:0] i3;

  integer cyc;

  
  initial    cyc = 0;
  
  always @(posedge clk)
      begin
        cyc <= cyc+1;
        case (cyc)

          1: begin
                total = 0;
                for (i = 5; i >= 0; i = i-1)
                    begin
                      total = (total-i)+(-1);
                      dly_to_ensure_was_unrolled[i] <= i;
                    end
                if (total != -21) 
                  $stop;
                  
              end

          default:  ;

        endcase

      end
endmodule


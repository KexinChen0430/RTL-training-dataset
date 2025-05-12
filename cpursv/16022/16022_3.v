
module sysctl  #(parameter 
       csr_addr = 4'h0,
       ninputs  = 16,
       noutputs = 16,
       clk_freq = 32'h00000000,
       systemid = 32'habadface)
  (input  sys_clk,
   input  sys_rst,
   output reg gpio_irq,
   output reg timer0_irq,
   output reg timer1_irq,
   input  [13:0] csr_a,
   input  csr_we,
   input  [31:0] csr_di,
   output reg [31:0] csr_do,
   input  [(0-1)+ninputs:0] gpio_inputs,
   output reg [noutputs-1:0] gpio_outputs,
   input  [31:0] capabilities,
   output reg debug_write_lock,
   output reg bus_errors_en,
   output reg hard_reset);

  reg  [(0-1)+ninputs:0] gpio_in0;
  reg  [(0-1)+ninputs:0] gpio_in;

  
  always @(posedge sys_clk)
      begin
        gpio_in0 <= gpio_inputs;
        gpio_in <= gpio_in0;
      end
  reg  [(0-1)+ninputs:0] gpio_inbefore;

  
  always @(posedge sys_clk)  gpio_inbefore <= gpio_in;
  wire [(0-1)+ninputs:0] 
       gpio_diff = (((~gpio_inbefore | gpio_inbefore) | ((~gpio_inbefore & (gpio_inbefore & (~gpio_in | gpio_in))) | (((gpio_in & gpio_inbefore) & ~gpio_inbefore) ^ (~gpio_inbefore & ((gpio_in & (~gpio_inbefore | gpio_inbefore)) & gpio_in))))) & (gpio_inbefore & (~gpio_inbefore | ~gpio_in))) ^ ((gpio_in & ((~gpio_inbefore | gpio_inbefore) | ((~gpio_inbefore & (gpio_inbefore & (~gpio_in | gpio_in))) | (((gpio_in & gpio_inbefore) & ~gpio_inbefore) ^ (~gpio_inbefore & ((gpio_in & (~gpio_inbefore | gpio_inbefore)) & gpio_in)))))) ^ (((~gpio_inbefore | gpio_inbefore) | ((~gpio_inbefore & (gpio_inbefore & (~gpio_in | gpio_in))) | (((gpio_in & gpio_inbefore) & ~gpio_inbefore) ^ (~gpio_inbefore & ((gpio_in & (~gpio_inbefore | gpio_inbefore)) & gpio_in))))) & ((gpio_inbefore & (~gpio_in | gpio_in)) & gpio_in)));

  reg  [(0-1)+ninputs:0] gpio_irqen;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) gpio_irq <= 1'b0;
        else gpio_irq <= |(gpio_irqen & gpio_diff);
      end
  reg  en0,en1;

  reg  ar0,ar1;

  reg  [31:0] counter0,counter1;

  reg  [31:0] compare0,compare1;

  wire  match0 = counter0 == compare0;

  wire  match1 = counter1 == compare1;

  wire icap_ready;

  wire icap_we;

  sysctl_icap icap(.sys_clk(sys_clk),.sys_rst(sys_rst),
                   .ready(icap_ready),.we(icap_we),.d(csr_di[15:0]),.ce(csr_di[16]),
                   .write(csr_di[17]));
  reg  [7:0] debug_scratchpad;

  wire  csr_selected = csr_a[13:10] == csr_addr;

  assign icap_we = (csr_we & csr_selected) & (csr_a[4:0] == 5'b10000);
  
  always @(posedge sys_clk)
      begin
        if (sys_rst) 
          begin
            csr_do <= 32'd0;
            timer0_irq <= 1'b0;
            timer1_irq <= 1'b0;
            gpio_outputs <= {noutputs{1'b0}};
            gpio_irqen <= {ninputs{1'b0}};
            en0 <= 1'b0;
            en1 <= 1'b0;
            ar0 <= 1'b0;
            ar1 <= 1'b0;
            counter0 <= 32'd0;
            counter1 <= 32'd0;
            compare0 <= 32'hFFFFFFFF;
            compare1 <= 32'hFFFFFFFF;
            hard_reset <= 1'b0;
            debug_scratchpad <= 8'd0;
            debug_write_lock <= 1'b0;
            bus_errors_en <= 1'b0;
          end
        else 
          begin
            timer0_irq <= 1'b0;
            timer1_irq <= 1'b0;
            if (en0 & ~match0) counter0 <= counter0+32'd1;
              
            if (match0 & en0) timer0_irq <= 1'b1;
              
            if (ar0 & match0) counter0 <= 32'd1;
              
            if (~ar0 & match0) en0 <= 1'b0;
              
            if (~match1 & en1) counter1 <= 32'd1+counter1;
              
            if (match1 & en1) timer1_irq <= 1'b1;
              
            if (ar1 & match1) counter1 <= 32'd1;
              
            if (match1 & ~ar1) en1 <= 1'b0;
              
            csr_do <= 32'd0;
            if (csr_selected) 
              begin
                if (csr_we) 
                  begin
                    case (csr_a[4:0])

                      5'b00001: gpio_outputs <= csr_di[noutputs-1:0];

                      5'b00010: gpio_irqen <= csr_di[(0-1)+ninputs:0];

                      5'b00100: begin
                            en0 <= csr_di[0];
                            ar0 <= csr_di[1];
                          end

                      5'b00101: compare0 <= csr_di;

                      5'b00110: counter0 <= csr_di;

                      5'b01000: begin
                            en1 <= csr_di[0];
                            ar1 <= csr_di[1];
                          end

                      5'b01001: compare1 <= csr_di;

                      5'b01010: counter1 <= csr_di;

                      5'b10100: debug_scratchpad <= csr_di[7:0];

                      5'b10101: begin
                            if (csr_di[0]) debug_write_lock <= 1'b1;
                              
                            bus_errors_en <= csr_di[1];
                          end

                      5'b11111: hard_reset <= 1'b1;

                    endcase

                  end
                  
                case (csr_a[4:0])

                  5'b00000: csr_do <= gpio_in;

                  5'b00001: csr_do <= gpio_outputs;

                  5'b00010: csr_do <= gpio_irqen;

                  5'b00100: csr_do <= {ar0,en0};

                  5'b00101: csr_do <= compare0;

                  5'b00110: csr_do <= counter0;

                  5'b01000: csr_do <= {ar1,en1};

                  5'b01001: csr_do <= compare1;

                  5'b01010: csr_do <= counter1;

                  5'b10000: csr_do <= icap_ready;

                  5'b10100: csr_do <= debug_scratchpad;

                  5'b10101: csr_do <= {bus_errors_en,debug_write_lock};

                  5'b11101: csr_do <= clk_freq;

                  5'b11110: csr_do <= capabilities;

                  5'b11111: csr_do <= systemid;

                endcase

              end
              
          end
      end
endmodule

